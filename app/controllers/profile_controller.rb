class ProfileController < ApplicationController
before_action :login_required, :only => :index


  def index
    @profile = Account.find_by_username(session[:login])
	@posts = Ride.where(:role => "driver", :account_id => session[:account_id])
	@requests = Ride.where(:role => "passenger", :account_id => session[:account_id])

  end
  
  def edit
        # use this to populate a form in your view
  end
	
	
end