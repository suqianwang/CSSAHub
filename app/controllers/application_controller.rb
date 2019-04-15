class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  helper_method :current_user
 
  def current_user
    return Account.find(session[:account_id]) rescue nil
  end
  
  def login_required
    redirect_to('/login') if current_user.blank?
  end
  
  def check_admin
    if current_user.isAdmin == true
      return true
    else
      redirect_to services_path
    end
  end
  
end
