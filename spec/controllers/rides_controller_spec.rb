RSpec.describe RidesController, :type => :controller do
  describe "GET index" do
    it "assigns @rides as all rides" do
      ride = Ride.create!(role: "passenger")
      get :index
      expect(assigns(:rides)).to eq([ride])
    end
  end
  
  describe "GET new" do
    it "makes a new, unsaved ride" do
      get :new
      expect(assigns(:ride)).to be_a_new(Ride)
      expect(assigns(:ride)).to_not be_persisted
    end
  end
      
  
  describe "POST create" do
    it "saves a new ride" do
      assert_difference 'Ride.count' do
        post :create, :params => { :ride => { :role => 'passenger' } }
      end
    end
    
    it "redirects to the index" do
      post :create, :params => { :ride => { :role => 'driver' } }
      expect(response).to redirect_to(driver_path)
    end
    
    context "with valid attributes" do
      it "assigns and saves created ride as @ride" do
        post :create, :params => { :ride => { :role => 'passenger' } }
        expect(assigns(:ride)).to be_a(Ride)
        expect(assigns(:ride)).to be_persisted
      end
    end
    
    context "with invalid attributes" do
      it "assigns created ride as @ride" do
        Ride.any_instance.stub(:save).and_return(false)
        post :create, :params => { :ride => { :role => 'invalid role' } }
        expect(assigns(:ride)).to be_a(Ride)
      end
    end
  end
end