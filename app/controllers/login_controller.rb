class LoginController < ApplicationController
  def index
    if not current_user.blank?
      redirect_to services_path
    end
  end
  def show
  end
  def create
    account = Account.find_by_username(params[:username])
    if account && account.authenticate(params[:password]) && account.archived == false
      session[:account_id] = account.id
      session['login'] = account.username
      
  	  if (session['login'] == "admin")
  		  redirect_to admin_index_path
  	  else
        redirect_to services_path, notice: "Logged in!"
      end
    elsif account.archived == true
	  flash.now[:alert] = "Your account has been disabled. Please contact an administrator for assistance."
      render "index"
    else
      flash.now[:alert] = "Username or password is invalid"
      render "index"
    end
  end

  def destroy
    session['login'] = nil
	  session[:account_id] = nil
    redirect_to login_index_path
  end
end
