class ApplicationController < ActionController::Base
 helper_method :current_user
 
  def current_user
    if session[:account_id]
      @current_user ||= Account.find(session[:account_id])
    else
      @current_user = nil
    end
  end
  
  def login_required
    redirect_to('/login') if current_user.blank?
  end
  
  def check_admin
	if session['login'] == "admin"
	  #return true
	  redirect_to admin_index_path
	else
	  redirect_to rides_path
	end
  end
  
end
