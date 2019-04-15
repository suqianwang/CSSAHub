RSpec.describe LoginController, :type => :controller do
  before(:each) do
    @account = Account.create(username: "bob", email: "bob@tamu.edu")
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end
  
  describe "GET #index" do
    context "user is logged in" do
      it "should redirect to service hub page" do
        session[:account_id] = @account.id
        session['login'] = @account.username
        get :index
        expect(response).to redirect_to(services_path)
      end
    end
    context "user is not logged in" do
      it "should redirect to google auth page" do
        session[:account_id] = nil
        session['login'] = nil
        get :index
        expect(response).to redirect_to('/auth/google_oauth2')
      end
    end
  end
  
  describe "POST #create" do
    it "assigns to account from auth" do
      post :create
      expect(assigns(:account)).to eq(@account)
    end
    
    it "redirects logins to archived accounts to home page" do
      @account.archived = true
      @account.save
      post :create
      expect(response).to redirect_to(home_index_path)
    end
    
    it "sets session variables for account" do
      post :create
      expect(session[:account_id]).to eq(@account.id)
      expect(session['login']).to eq(@account.username)
    end
    
    it "redirects to admin page for admin accounts" do
      @account.isAdmin = true
      @account.save
      post :create
      expect(response).to redirect_to(admin_index_path)
    end
    
    it "redirects to services page for regular accounts" do
      post :create
      expect(response).to redirect_to(services_path)
    end
    
    it "redirects to home page for non-TAMU emails" do
      Rails.application.env_config["omniauth.auth"].info.email = "bob@gmail.com"
      post :create
      expect(assigns(:valid_email)).to eq(false)
      Rails.application.env_config["omniauth.auth"].info.email = "bob@tamu.edu"
    end
  end
  
  describe "logout" do
    it "#DESTROY session" do
	  post :destroy
	  expect(session['login']).to eq(nil)
	  expect(response).to redirect_to(home_index_path) 
    end
  end

  
  #   describe "login with archive account" do
  #   it "should not login" do
	 # @archive_account = FactoryBot.create :account, :archived_user
	 # post :create,  params: { password: @archive_account.password, username: @archive_account.username }
  #     expect(response).to render_template :index
  #   end
  # end
  
end