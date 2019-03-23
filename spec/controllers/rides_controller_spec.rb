require 'pry'

RSpec.describe RidesController, :type => :controller do
  before do
    @account = FactoryBot.create(:account, :user)
    login(@account)
    @ride_params = { role: 'driver', departure: 'Zachry', destination: 'HEB', 
                     start_date: '2019-04-19', end_date: '2019-04-25', start_time: '12:05:08', end_time: '16:00:00', seats: 5 }
    @invalid_params = @ride_params.dup
    @invalid_params[:role] = 'invalid role'
  end
  
  describe "GET index" do
    it "assigns @rides as all rides" do
      get :index
      expect(assigns(:rides)).to eq(Ride.all)
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
        post :create, :params => { ride: @ride_params }
      end
    end
    
    it "redirects to the index" do
      post :create, :params => { :ride => @ride_params }
      expect(response).to redirect_to(rides_url(Ride.last))
    end
    
    context "with valid attributes" do
      it "assigns and saves created ride as @ride" do
        post :create, :params => { :ride => @ride_params }
        expect(assigns(:ride)).to be_a(Ride)
        expect(assigns(:ride)).to be_persisted
      end
    end
    
    context "with invalid attributes" do
      it "assigns created ride as @ride" do
        post :create, :params => { :ride => @invalid_params }
        Ride.any_instance.stub(:save).and_return(false)
        expect(assigns(:ride)).to be_a(Ride)
      end
    end
  end
  
  describe "GET show" do
    it "assigns the requested ride as @ride" do
      ride = Ride.create(@ride_params.merge(:account => @account))
      get :show, :params => { id: ride.id }
      expect(assigns(:ride)).to eq ride
    end
  end
end