require 'pry'

class RidesController < ApplicationController
  before_action :login_required, :only => [:index, :new, :show, :create, :destroy, :update, :edit]
  
  def index
    if session['login']=="admin"
      @rides = Ride.all.order('start_date DESC')
    else
      @rides = Ride.where('end_date >= ?', Date.today)
	end
  end
  
  def new
    if session['login']=="admin"
	  redirect_to admin_index_path
  	else
        @ride = Ride.new
  	end
  end
  
  def create
    @ride = current_user.rides.new(ride_params)
	if not @ride.end_date.empty? and not @ride.start_date.empty?
	  begin
	    @ride.end_date = Date.strptime(@ride.end_date, '%m/%d/%Y')
	    @ride.start_date = Date.strptime(@ride.start_date, '%m/%d/%Y')
	  rescue ArgumentError
	  end
	    if @ride.save
          redirect_to rides_path, notice: 'Ride successfully created'
        else
          redirect_to new_ride_path, notice: 'Invalid ride!'
        end
	else
       redirect_to new_ride_path, notice: 'Invalid ride!'
	end
  end
  
  def show
    @ride = Ride.find(params[:id])
	@ride_email = Account.where(:id => @ride.account_id).first
  end

  def destroy
  	Ride.destroy(params[:id])
	if session['login']=="admin"
  	  respond_to do |format|
        format.html { redirect_to rides_path, notice: 'Ride was successfully destroyed.' }
        format.json { head :no_content }
      end
	 else
	   respond_to do |format|
        format.html { redirect_to profile_index_path, notice: 'Ride was successfully destroyed.' }
        format.json { head :no_content }
		end
	 end
  end

  def edit
    # Check if user owns the ride. If not, throw 401 Unauthorized
     @ride = Ride.find(params[:id])
     if not current_user.id == @ride.account_id or session['login'] == "admin"
       render '401', :status => 401
     end
  end
  
  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(ride_params)
	    @ride.save
        flash[:notice] = "Ride was successfully updated."
        redirect_to profile_index_path
	end
  end

  private
  
  def ride_params
    params.require(:ride).permit(:role, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats)
  end

end
