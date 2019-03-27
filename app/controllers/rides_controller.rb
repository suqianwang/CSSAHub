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
      render new_ride_path
    end
  end
  
  def show
    # @ride = current_user.rides.find(params[:id])
    @ride = Ride.find(params[:id])
  end

  def destroy

  end

  def edit
    # Check if user owns the ride. If not, throw 401 Unauthorized
    @ride = Ride.find(params[:id])
    if not current_user.id == @ride.id
      render '401', :status => 401
    end
  end

  private
  
  def ride_params
    params.require(:ride).permit(:role, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats)
  end

end
