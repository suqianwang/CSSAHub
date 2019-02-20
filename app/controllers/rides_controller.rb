class RidesController < ApplicationController
  def index
    @rides = Ride.all
  end
  
  def new
    @ride = Ride.new
  end
  
  def create
    @ride = Ride.new(params[:ride].permit(:role))
    if @ride.save
      redirect_to rides_path
    end
  end
end
