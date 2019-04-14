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
    if not valid_email
      flash[:notice] = "You must login with a valid TAMU email"
      redirect_to 'login'
    end
    
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
  end

  def destroy
    session['login'] = nil
	  session[:account_id] = nil
    redirect_to login_index_path
  end
end
