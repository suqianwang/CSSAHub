class ProfileController < ApplicationController
before_action :login_required, :only => :index


  def index
    @profile = Account.find_by_username(session[:login])
	puts @profile

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