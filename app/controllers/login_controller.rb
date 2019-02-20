class LoginController < ApplicationController
  def index
  end
  def show
  end
  def create
    if not params.has_key?('username') or params['username'].empty?
      redirect_to login_index_path
    elsif not params.has_key?('password') or params['password'].empty?
      redirect_to login_index_path
    else
      session['login'] = params['username']
    end
  end

  def logout
    session['login'] = nil
    redirect_to login_index_path
  end
end
