RSpec.describe AdminController, :type => :controller do
  before do
    @account = FactoryBot.create :account, :user
	@admin = FactoryBot.create :account, :admin
  end
  
  describe "GET index" do
    it "does not user to navigate to admin page" do
	  login(@account)
      get :index
	  expect(response).to redirect_to(rides_path)
    end
  end
  
  describe "GET index" do
    it "allow admin to navigate to admin page" do
	  login(@admin)
      get :index
	  expect(response).to render_template :index
    end
  end
 end