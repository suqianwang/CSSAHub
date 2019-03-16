class PassengerController < ApplicationController
  def index
    render "index"
  end
  def show
  end
  def create
    flash[:notice] = "Ride Request Success!"
    redirect_to rides_path
  end
end

