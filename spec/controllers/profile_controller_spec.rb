RSpec.describe ProfileController, :type => :controller do
  before do
    @account = FactoryBot.create(:account, :user)
    @admin = FactoryBot.create :account, :admin
    
	@ride = FactoryBot.build_stubbed(:ride, account: @account)
  end
  
    describe "GET index" do
    it "assigns @profile as all rides" do
	  login(@account)
      get :index
      expect(assigns(:profile)).to eq(Account.find_by_username(session[:login]))
    end
	end
	
	describe "GET index" do
    it "assigns @posts as the user's posted rides" do
	  login(@account)
      get :index
      expect(assigns(:posts).count).to eq(0)
    end
	end
	
	describe "GET index" do
    it "assigns @requests as the user's requested rides" do
	  login(@account)
      get :index
      expect(assigns(:requests).count).to eq(0)
    end
	end
	
	describe "GET index" do
    it "assigns @requests as the user's requested rides" do
	  login(@admin)
      get :index
      expect(response).to redirect_to admin_index_path
    end
	end
end