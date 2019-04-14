require 'pry'

class LoginController < ApplicationController
  def index
    if not current_user.blank?
      redirect_to services_path
    end
  end
  
  def show
  end
  
  def create
    auth = request.env["omniauth.auth"]
    valid_email = !!(auth.info.email =~ /\A\S+@tamu.edu\z/)
    if valid_email
        account = Account.from_omniauth(auth)
      
      if (account.archived == true)
        flash.now[:alert] = "Your account has been disabled. Please contact an administrator for assistance."
        render "index"
      end
      
      reset_session # protects against session fixation
      session[:account_id] = account.id
      session['login'] = account.username
      
      if (current_user.isAdmin == true)
    	  redirect_to admin_index_path
      else
        redirect_to services_path, notice: "Logged in!"
      end
    else
      flash[:alert] = "Login failed. You must login with a valid TAMU email"
      redirect_to home_index_path
    end
    
    
  end

  def destroy
    session['login'] = nil
	  session[:account_id] = nil
    redirect_to home_index_path
  end
end
