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
	  #puts @admin.username
	  puts session['login']
      get :index
	  expect(response).to redirect_to(admin_index_path)
    end
  end
 end