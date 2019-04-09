require 'pry'

class RidesController < ApplicationController
  before_action :login_required, :only => :index


  def index

    if session['login']=="admin"
      @rides = Ride.all.order('start_date DESC')
    else
      @rides = Ride.where('end_date >= ?', Date.today)
    end

    @all_types = Ride.all_types
    permitted = params.permit(type: [:driver, :passenger])
    @selected_type = permitted[:type] || session[:type] || {}

    sort = params[:sort] || session[:sort] || 'asc'
    ordering,@date_header = {:start_datetime => sort}, 'hilite'


    if @selected_type == {}
      # @selected_type = @all_types
      @selected_type = Hash[@all_types.map {|role| [role, 1]}]
    end

    if params[:sort] != session[:sort] or params[:type] != session[:type]
      session[:sort] = sort
      session[:type] = @selected_type
      redirect_to :sort => sort, :type => @selected_type and return
    end

    @rides = Ride.where(:role => @selected_type.keys).order(ordering)

  end
  
  def new
    if session['login']=="admin"
	    redirect_to admin_index_path
  	else
      @ride = Ride.new
  	end
  end
  
  def create
    @ride = current_user.rides.new(ride_params)
    respond_to do |format|
      if @ride.save
        format.html do
          flash[:notice] = 'Ride successfully created'
          redirect_to controller: 'rides', action: 'show', id: @ride.id
        end

        format.json { render :show, status: :created, location: @ride }
      else
        format.html { render :new }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @ride = Ride.find(params[:id])
    @rides = Ride.match_ride(params[:id])
  end

  def destroy
  	Ride.destroy(params[:id])
  	if session['login']=="admin"
  	  respond_to do |format|
        format.html { redirect_to rides_path, notice: 'Ride was successfully destroyed.' }
        format.json { head :no_content }
      end
	  else
	    respond_to do |format|
        format.html { redirect_to profile_index_path, notice: 'Ride was successfully destroyed.' }
        format.json { head :no_content }
	    end
	  end
  end

  def edit
    # Check if user owns the ride. If not, throw 401 Unauthorized
     @ride = Ride.find(params[:id])
     if not current_user.id == @ride.account_id or session['login'] == "admin"
       render '401', :status => 401
     end
  end
  
  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(ride_params)
	    @ride.save
      flash[:notice] = "Ride was successfully updated."
	  end
	  
	  redirect_to profile_index_path
  end

  def contact
    @ride = Ride.find(params[:id])
    @contact = @ride.account
  end

  private

  def ride_params
    params.require(:ride).permit(:role, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats)
  end
end
