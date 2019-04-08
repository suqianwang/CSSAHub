RSpec.describe ServicesController, type: :controller do
before do
    @account = FactoryBot.create :account, :user
	@admin = FactoryBot.create :account, :admin

  end

  describe "GET #index" do
    it "should get index" do
	  login(@account)
      get :index
      expect(response).to render_template :index
    end
    
    it "should redirect admin to admin page" do
	  login(@admin)
      get :index
      expect(response).to redirect_to(admin_index_path)
    end
  end
  
end
