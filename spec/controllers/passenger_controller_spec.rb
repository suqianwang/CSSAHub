RSpec.describe PassengerController, type: :controller do
  before do
    @account = FactoryBot.create :account, :user
  end
  describe "index - GET #index" do
    it "should get index" do
      login(@account)
      get :index
      expect(response).to render_template :index
    end

    it "should redirect if not logged in" do
      get :index
      expect(response).to redirect_to login_index_path
    end
  end

  describe "create - Submit form" do
    it "should redirect to rides page" do
      login(@account)
      post :create
      expect(response).to redirect_to rides_path
    end
  end

end
