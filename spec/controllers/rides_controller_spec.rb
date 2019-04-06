RSpec.describe RidesController, :type => :controller do
  before do
    @account = FactoryBot.create(:account, :user)
	@admin = FactoryBot.create :account, :admin
    @ride_params = { role: 'driver', departure: 'Zachry', destination: 'HEB',
                     start_date: (Date.today+1).to_s, end_date: (Date.today+2).to_s, start_time: '8:00', end_time:'12:00', seats: 5 }
    @invalid_params = @ride_params.dup
    @invalid_params[:role] = 'invalid role'
  end

  describe "GET index" do
    it "assigns @rides as all rides" do
      login(@account)
      get :index
      expect(assigns(:rides).count).to eq(0)
    end
  end
 
 describe "GET index" do
    it "assigns @rides as all rides for admin" do
      login(@admin)
      get :index
      expect(assigns(:rides).count).to eq(0)
    end
  end
  
  
  describe "GET new" do
    it "makes a new, unsaved ride" do
      login(@account)
      get :new
      expect(assigns(:ride)).to be_a_new(Ride)
      expect(assigns(:ride)).to_not be_persisted
    end
  end
  
  describe "GET new" do
    it "makes admin redirect to admin page" do
      login(@admin)
      get :new
      expect(response).to redirect_to(admin_index_path)
    end
  end

  describe "POST create" do
    it "saves a new ride" do
	  login(@account)
      assert_difference 'Ride.count' do
        post :create, :params => {ride: @ride_params}
      end
    end

    it "redirects to the index" do
	  login(@account)
      post :create, :params => {:ride => @ride_params}
      expect(response).to redirect_to(rides_path)
    end

    context "with valid attributes" do
      it "assigns and saves created ride as @ride" do
	    login(@account)
        post :create, :params => {:ride => @ride_params}
        expect(assigns(:ride)).to be_a(Ride)
        expect(assigns(:ride)).to be_persisted
      end
    end

    context "with invalid attributes" do
      it "assigns created ride as @ride" do
	    login(@account)
        post :create, :params => {:ride => @invalid_params}
        Ride.any_instance.stub(:save).and_return(false)
        expect(assigns(:ride)).to be_a(Ride)
      end

      it "stays on form page" do
	    login(@account)
        r = post :create, :params => {:ride => @invalid_params}
        Ride.any_instance.stub(:save).and_return(false)
        expect(r).to redirect_to(new_ride_path)
      end
    end
  end

  describe "GET show" do
    it "assigns the requested ride as @ride" do
	  login(@account)
      ride = Ride.create(@ride_params.merge(:account => @account))
      get :show, :params => {id: ride.id}
      expect(assigns(:ride)).to eq ride
    end
  end

  describe "GET destroy" do
    it "should delete ride for user" do
	  login(@account)
      ride = Ride.create(@ride_params.merge(:account => @account))
      expect {
        delete :destroy, params: {id: ride.id}
      }.to change(Ride, :count).by(-1)
    end
  end
  
  describe "GET destroy" do
    it "should delete ride for admin" do
      ride = Ride.create(@ride_params.merge(:account => @account))
	  login(@admin)
      expect {
        delete :destroy, params: {id: ride.id}
      }.to change(Ride, :count).by(-1)
    end
  end
  
  describe "GET EDIT" do
    it "should edit ride" do
	  login(@account)
      ride = Ride.create(@ride_params.merge(:account => @account))
      get :edit, :params => {id: ride.id}
	  expect(response).to render_template('edit')
    end
  end
  
  describe "GET EDIT" do
    it "should not allow admin to edit ride" do
      ride = Ride.create(@ride_params.merge(:account => @account))
      login(@admin)
	  get :edit, :params => {id: ride.id}
	  expect(response.status).to eq(401)
    end
  end
  
  describe "GET UPDATE" do
    it "should update a ride" do
      login(@account)
	  ride = Ride.create(@ride_params.merge(:account => @account))
	  put :update, params: {:id => ride.id, :ride => { role: 'driver', departure: 'Zachry', destination: 'HEB', start_date: (Date.today+1).to_s, end_date: (Date.today+2).to_s, start_time: '8:00', end_time:'12:00', seats: 2 }}
       expect(response).to redirect_to profile_index_path
    end
  end
  
end