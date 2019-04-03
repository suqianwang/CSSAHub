require 'pry'

class RidesController < ApplicationController
  before_action :login_required, :only => :index
  def index
    @rides = Ride.all
  end
  
  def new
    @ride = Ride.new
  end
  
  def create
    @ride = current_user.rides.new(ride_params)
    if @ride.save
      redirect_to rides_path, notice: 'Ride successfully created'
    else
      redirect_to new_ride_path, notice: 'Invalid ride!'
    end
  end
  
  def show
    @ride = Ride.find(params[:id])
  end

  def destroy
  	Ride.destroy(params[:id])
  	respond_to do |format|
        format.html { redirect_to request.referrer, notice: 'Ride was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  def edit
     # Check if user owns the ride. If not, throw 401 Unauthorized
     @ride = Ride.find(params[:id])
     if not current_user.id == @ride.account_id
       render '401', :status => 401
     end
  end
  
  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(ride_params)
	    @ride.save
        flash[:notice] = "#Ride {@ride.id} was successfully updated."
        redirect_to profile_index_path
	end
  end

  private
  
  def ride_params
    params.require(:ride).permit(:role, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats)
  end

end
