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
	
	
  private
    def profile_params
      params.require(:account).permit(:username, :email, :name, :password, :password_confirmation, :terms_and_conditions)
    end


    def set_profile
      @profile = Account.find(params[:id])
	end
end