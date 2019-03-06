RSpec.describe ServicesController, type: :controller do
  describe "GET #index" do
    it "should get index" do
      get :index
      expect(response).to render_template :index
    end
    
    # it "should assign all valid service types to @service_types" do
    #   get :index
    #   expect(assigns[:service_types]).to eq(Service.subclasses)
    # end
  end
end
