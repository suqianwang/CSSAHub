RSpec.describe LoginController, :type => :controller do
before do
    @account = FactoryBot.create :account, :user
  end
  
  describe "login with correct information" do
    it "should login" do
	  post :create,  params: { password: @account.password, username: @account.username  }
	  expect(controller.session[:account_id]).to eq(@account.id)
	  expect(controller.session['login']).to eq(@account.username)
	  expect(response).to redirect_to(services_path)
    end
  end
  
  describe "login with incorrect password" do
    it "should not login and return errors" do
	  post :create,  params: { password: @account.password + "aaa", username: @account.username }
    expect(controller.session[:account_id]).to be_nil
	  expect(response).to render_template :index
    end
  end

describe "login with incorrect username" do
  it "should not login and return errors" do
    post :create,  params: { password: @account.password, username: @account.username + "aaa" }
    expect(controller.session[:account_id]).to be_nil
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