require 'pry'

class ProfileController < ApplicationController
before_action :login_required, :only => [:index, :edit, :update]


  def index
    if current_user.isAdmin == true
	  redirect_to admin_index_path
	else
    @profile = Account.find_by_username(session[:login])
	@posts = Ride.where(:role => "driver", :account_id => session[:account_id]).where('end_date >= ?', Date.today)
	@requests = Ride.where(:role => "passenger", :account_id => session[:account_id]).where('end_date >= ?', Date.today)
	@past = Ride.where(:account_id => session[:account_id]).where('end_date < ?', Date.today)
	end
  end

 
end