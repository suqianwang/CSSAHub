class LoginController < ApplicationController
  def index
  end
  def show
  end
  def create
    account = Account.find_by_username(params[:username])
    if account && account.authenticate(params[:password])
      session[:account_id] = account.id
      session['login'] = account.username
	  if (session['login'] == "admin")
		redirect_to admin_index_path
	  else
        redirect_to rides_path, notice: "Logged in!"
      end
    else
      flash.now[:alert] = "Email or password is invalid"
      render "index"
    end
  end

  def destroy
    session['login'] = nil
	session[:account_id] = nil
    redirect_to login_index_path
  end
end
