RSpec.describe ProfileController, :type => :controller do
  before do
    @account = FactoryBot.create(:account, :user)
    login(@account)
	@ride = FactoryBot.build_stubbed(:ride, account: @account)
  end
  
    describe "GET index" do
    it "assigns @profile as all rides" do
      get :index
      expect(assigns(:profile)).to eq(Account.find_by_username(session[:login]))
    end
	end
	
	describe "GET index" do
    it "assigns @posts as the user's posted rides" do
      get :index
      expect(assigns(:posts)).to eq(Ride.where(:role => "driver", :account_id => session[:account_id]))
    end
	end
	
	describe "GET index" do
    it "assigns @requests as the user's requested rides" do
      get :index
      expect(assigns(:requests)).to eq(Ride.where(:role => "passenger", :account_id => session[:account_id]))
    end
	end
end