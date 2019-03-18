class RidesController < ApplicationController
  before_action :login_required, :only => :index
  def index
    @rides = Ride.all
  end
  
  def new
    @ride = Ride.new
  end
  
  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      if@ride.role == 'passenger'
        redirect_to passenger_path
      elsif@ride.role == 'driver'
        redirect_to driver_path
      end
    end
  end
  
  private
  
  def ride_params
    params.require(:ride).permit(:role)
  end
end
