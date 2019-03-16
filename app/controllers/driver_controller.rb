class DriverController < ApplicationController
  def index
  end
  def show
  end
  def create
    flash[:notice] = "Ride Create Success!"
    redirect_to rides_path
  end
end

