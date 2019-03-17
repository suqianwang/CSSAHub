RSpec.describe HomeController, :type => :controller do
before do
    @account = FactoryBot.create :account, :user
	end

  describe "GET #index" do
    it "should get index" do
	login(@account)
    get :index
    expect(response).to have_http_status(:success)
    end
  end
end
