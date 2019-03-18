class DriverController < ApplicationController
  def index
    if !session.has_key?('login') or session[:login].empty?
      flash[:notice] = "Please log in before creating driver form"
      redirect_to login_index_path
    end
  end
  def show
  end
  def create
    flash[:notice] = "Ride Create Success!"
    redirect_to rides_path
  end
end

