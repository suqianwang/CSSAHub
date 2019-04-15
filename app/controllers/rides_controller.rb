require 'pry'

class RidesController < ApplicationController
  before_action :login_required, :only => :index


  def index

    @all_types = Ride.all_types
    permitted = params.permit(type: [:driver, :passenger])
    @selected_type = permitted[:type] || session[:type] || {}

    if @selected_type == {}
      # @selected_type = @all_types
      @selected_type = Hash[@all_types.map {|role| [role, 1]}]
    end

    if params[:type] != session[:type]
      session[:type] = @selected_type
      redirect_to :type => @selected_type and return
    end

    if current_user.isAdmin == true
      @rides = Ride.where(:role => @selected_type.keys).order(:start_datetime => 'asc')
    else
      @rides = Ride.where(:role => @selected_type.keys).order(:start_datetime => 'asc').where('start_date >= ?', Date.today)
    end

  end

  def new
    if current_user.isAdmin == true
      redirect_to admin_index_path
    else
      @ride = Ride.new
    end
  end

  def create
    # byebug
    @ride = current_user.rides.new(ride_params)
    respond_to do |format|
      if @ride.save
        format.html do
          flash[:notice] = 'Ride successfully created'
          redirect_to controller: 'rides', action: 'show', id: @ride.id
        end

        format.json {render :show, status: :created, location: @ride}
      else
        format.html {render :new}
        format.json {render json: @ride.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
    @ride = Ride.find(params[:id])
    @rides = Ride.match_ride(params[:id])
	rescue ActiveRecord::RecordNotFound
        redirect_to "/home/index"
  end

  def destroy
    Ride.destroy(params[:id])
    respond_to do |format|
      format.html {redirect_to rides_path, notice: 'Ride was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def edit
    # Check if user owns the ride. If not, throw 401 Unauthorized
    @ride = Ride.find(params[:id])
    if not current_user.id == @ride.account_id or current_user.isAdmin == true
      render '401', :status => 401
    end
  end

  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(ride_params)
      @ride.save
      flash[:notice] = "Ride was successfully updated."
      redirect_to profile_index_path
    else
      flash[:alert] = "Field is missing or invalid in the form."
      respond_to do |format|
        format.html {}
        format.js {render js: 'window.top.location.reload();$(document).scrollTop(0);'}
      end
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:role, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats)
  end
end
