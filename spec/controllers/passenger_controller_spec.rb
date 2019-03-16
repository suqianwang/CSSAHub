RSpec.describe DriverController, type: :controller do
  describe "index - GET #index" do
    it "should get index" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "create - Submit form" do
    it "should redirect to rides page" do
      post :create
      expect(response).to redirect_to rides_path
    end
  end
end
