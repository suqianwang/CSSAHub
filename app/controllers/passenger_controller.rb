class PassengerController < ApplicationController
  def index
  end
  def show
  end
  def create
      render "index"
  end
  def create2
    redirect_to rides_path
  end
end

