# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end

  def login(user)
	  account = Account.find_by_username(user.username)
    session[:account_id] = account.id
	  session['login']=account.username
	  @current_user ||= Account.find(session[:account_id])
  end

  def current_user
    Account.find_by_username(session[:username])
  end
end