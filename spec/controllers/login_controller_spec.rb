RSpec.describe LoginController, :type => :controller do
before do
    @account = FactoryGirl.create(:account)
  end
  
  describe "login with correct information" do
    it "should login" do
	  post :index,  params: { account: { email: @account.email, name: @account.name, password: @account.password, password_confirmation: @account.password, username: @account.username  } }
	  account=@account.username
	  controller.session[:account_id]=@account.id
	  controller.session['login']=@account.username
	  expect(session[:account_id]).to eq(@account.id)
	  expect(session['login']).to eq(@account.username)
	  expect(response).to redirect_to(rides_path)
    end
  end
  
  describe "login with incorrect information" do
    it "should not login and return errors" do
	  post :create,  params: { account: { email: @account.email, name: @account.name, password: @account.password, password_confirmation: @account.password, username: 'wrong' } }
      controller.session[:account_id] = nil
	  expect(response).to render_template :index
    end
  end
  
  describe "logout" do
    it "#DESTROY session" do
	  post :destroy
	  expect(session['login']).to eq(nil)
	  expect(response).to redirect_to(login_index_path) 
    end
  end

end