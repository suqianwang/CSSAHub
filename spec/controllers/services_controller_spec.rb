RSpec.describe ServicesController, type: :controller do
before do
    @account = FactoryBot.create :account, :user
  end

  describe "GET #index" do
    it "should get index" do
	  login(@account)
      get :index
      expect(response).to render_template :index
    end
    
    # it "should assign all valid service types to @service_types" do
    #   get :index
    #   expect(assigns[:service_types]).to eq(Service.subclasses)
    # end
  end
end
