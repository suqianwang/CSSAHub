class PassengerController < ApplicationController
  def index
  end
  def show
  end
  def create
    # account = Account.find_by_username(params[:username])
    # if account && account.authenticate(params[:password])
    #   session[:account_id] = account.id
    #   session['login'] = account.username
    #   redirect_to rides_path, notice: "Logged in!"
    # else
      flash.now[:alert] = "Form page now"
      render "index"
  end
end

