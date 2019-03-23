RSpec.describe RidesController, :type => :controller do
  before do
    @ride = FactoryBot.create :ride
  end

  describe "GET index" do
    it "assigns @rides as all rides" do
	  login(@ride.account)
      ride = Ride.create!(@ride.params)
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
        post :create, :params => @ride.params
      end
    end
    
    it "redirects to the index" do
      post :create, :params => @ride.params
      expect(response).to redirect_to(driver_path)
    end
    
    context "with valid attributes" do
      it "assigns and saves created ride as @ride" do
        post :create, :params => @ride.params
        expect(assigns(:ride)).to be_a(Ride)
        expect(assigns(:ride)).to be_persisted
      end
    end
    
    context "with invalid attributes" do
      it "assigns created ride as @ride" do
        Ride.any_instance.stub(:save).and_return(false)
        @ride.role = 'invalid role'
        post :create, :params => @ride.params
        expect(assigns(:ride)).to be_a(Ride)
      end
    end
  end
  
  describe "GET show" do
    it "assigns the requested ride as @ride" do
      ride = Ride.create!(@ride)
      get :show, {:id => ride.to_param}
      expect(assigns(:ride)).to_eq ride
    end
  end
end