require 'pry'

class RidesController < ApplicationController
  before_action :login_required, :only => [:index, :new, :show, :create, :destroy, :update, :edit]
  
  def index
    if session['login']=="admin"
      @rides = Ride.all.order('start_date DESC')
    else
      @rides = Ride.where('end_date >= ?', Date.today)
	  end
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
        format.html { redirect_to controller: 'rides', action: 'show', id: @ride.id, notice: 'Ride successfully created' }
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
