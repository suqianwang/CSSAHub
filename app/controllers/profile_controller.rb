class ProfileController < ApplicationController
before_action :login_required, :only => [:index, :edit, :update]


  def index
    if session['login']=="admin"
	  redirect_to admin_index_path
	else
    @profile = Account.find_by_username(session[:login])
	@posts = Ride.where(:role => "driver", :account_id => session[:account_id]).where('end_date < ?', DateTime.now)
	@requests = Ride.where(:role => "passenger", :account_id => session[:account_id]).where('end_date < ?', DateTime.now)
	@past = Ride.where(:account_id => session[:account_id]).where('end_date > ?', DateTime.now)
	end
  end
  
  def edit
        # use this to populate a form in your view
  end
  
  def update
    @profile = Account.find(params[:id])
    if @account.update_attributes(account_params)
	    @account.save
        flash[:notice] = "#Account was successfully updated."
        redirect_to profile_index_path
	end
  end
  
  
	private
	def account_params
      params.require(:account).permit(:username, :name, :password, :password_confirmation, :terms_and_conditions)
    end
end