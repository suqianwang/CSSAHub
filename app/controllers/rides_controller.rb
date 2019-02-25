class RidesController < ApplicationController
  def index
    @rides = Ride.all
  end
  
  def new
    @ride = Ride.new
  end
  
  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      redirect_to rides_path
    end
  end
  
  private
  
  def ride_params
    params.require(:ride).permit(:role)
  end
end
