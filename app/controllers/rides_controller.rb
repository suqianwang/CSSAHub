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
    binding.pry
    @ride = current_user.rides.new(ride_params)
    if @ride.save
      redirect_to ride_url(@ride.id), notice: 'Ride successfully created'
    end
  end
  
  def show
    @ride = current_user.rides.find(params[:id])
  end
  
  private
  
  def ride_params
    params.require(:ride).permit(:role, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats)
  end
end
