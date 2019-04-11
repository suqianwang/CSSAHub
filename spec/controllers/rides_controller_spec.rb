require 'spec_helper'

RSpec.describe RidesController, :type => :controller do
  before do
    @account = FactoryBot.create(:account, :user)
	  @admin = FactoryBot.create :account, :admin
    @ride_params = { role: 'driver', departure: 'Zachry Engineering Center, Spence Street, College Station, TX, USA', destination: 'H-E-B, Texas Avenue South, College Station, TX, USA',
                     start_date: (Date.today+1).strftime("%m/%d/%Y"), start_time: '08:00', end_time:'12:00', seats: 5 }
    @invalid_params = @ride_params.dup
    @invalid_params[:role] = 'invalid role'
	  @invalid_params_no_date = @ride_params.dup
    @invalid_params_no_date[:start_date] = nil
  end

  describe "GET index" do
    it "assigns @rides as all rides" do
      login(@account)
      post :create, :params => { ride: @ride_params }
      get :index
      expect(assigns(:rides).count).to eq(Ride.count)
    end
    it "assigns @rides as all rides for admin" do
      login(@admin)
      post :create, :params => { ride: @ride_params }
      get :index
      expect(assigns(:rides).count).to eq(Ride.count)
    end
    it "redirect if params filter option and session filter option differ" do
      login(@account)
      get :index, :params => {type: {driver: 1}}
      get :index
      expect(response).to redirect_to rides_path(type: {driver: 1})
    end
  end
  
  describe "GET new" do
    it "makes a new, unsaved ride" do
      login(@account)
      get :new
      expect(assigns(:ride)).to be_a_new(Ride)
      expect(assigns(:ride)).to_not be_persisted
    end
    it "makes admin redirect to admin page" do
      login(@admin)
      get :new
      expect(response).to redirect_to(admin_index_path)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "adds one ride to the database" do
  	    login(@account)
        assert_difference 'Ride.count' do
          post :create, :params => {ride: @ride_params}
        end
      end
      it "redirects to the index" do
  	    login(@account)
        post :create, :params => {ride: @ride_params}
        expect(response).to redirect_to(ride_path(assigns(:ride).id))
      end
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
        expect(response).to render_template :new
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
    it "should delete ride for admin" do
      ride = Ride.create(@ride_params.merge(:account => @account))
	    login(@admin)
      expect {
        delete :destroy, params: {id: ride.id}
      }.to change(Ride, :count).by(-1)
    end
  end
  
  describe "GET #edit" do
    it "should render ride editing form" do
	    login(@account)
      ride = Ride.create(@ride_params.merge(:account => @account))
      get :edit, :params => {id: ride.id}
	    expect(response).to render_template('edit')
    end
    it "should not allow admin to edit ride" do
      ride = Ride.create(@ride_params.merge(:account => @account))
      login(@admin)
  	  get :edit, :params => {id: ride.id}
  	  expect(response.status).to eq(401)
    end
  end
  
  describe "PUT #update" do
    let(:attr) do
      { :departure => "IAH" }
    end
    
    before(:each) do
      login(@account)
      @ride = Ride.create(@ride_params.merge(:account => @account))
      put :update, params: {:id => @ride.id, :ride => attr}
      @ride.reload
    end
    
    it { expect(response).to redirect_to profile_index_path }
    it { expect(assigns(:ride)).to eq(@ride) }
    it { expect(@ride.departure).to eq(attr[:departure]) }
    
  end
  
  
  describe "PUT #update" do
    let(:attr) do
      { :start_time => "" }
    end
    
    before(:each) do
      login(@account)
      @ride = Ride.create(@ride_params.merge(:account => @account))
      put :update, params: {:id => @ride.id, :ride => attr}
      @ride.reload
    end
    
    it "should not allow invalid input" do
      expect(response).to have_http_status(:no_content)
	 end
  end


  describe '#match_ride' do
    it 'match ride' do
      login(@account)
      @ride_1_params = { role: 'driver', departure: 'Zachry Engineering Center, Spence Street, College Station, TX, USA', destination: 'H-E-B, Texas Avenue South, College Station, TX, USA',
                         start_date: (Date.today+1).strftime("%m/%d/%Y"), start_time: '08:00', end_time:'12:00', seats: 2 }

      @ride_2_params = { role: 'passenger', departure: 'Zachry Engineering Center, Spence Street, College Station, TX, USA', destination: 'H-E-B, Texas Avenue South, College Station, TX, USA',
                         start_date: (Date.today+1).strftime("%m/%d/%Y"), start_time: '08:00', end_time:'12:00', seats: 5 }
      @ride_3_params = { role: 'passenger', departure: 'Zachry Engineering Center, Spence Street, College Station, TX, USA', destination: 'H-E-B, Texas Avenue South, College Station, TX, USA',
                         start_date: (Date.today+1).strftime("%m/%d/%Y"), start_time: '08:00', end_time:'12:00', seats: 2 }
      post :create, :params => {ride: @ride_1_params}
      ride_1 = Ride.last
      post :create, :params => {ride: @ride_2_params}
      ride_2 = Ride.last
      post :create, :params => {ride: @ride_3_params}
      ride_3 = Ride.last
      # it 'should not match if driver has lower capacity'
      expect(Ride.match_ride(ride_1.id)) .not_to include(ride_2)
      # it 'should not match if passenger has higher capacity'
      expect(Ride.match_ride(ride_2.id)) .not_to include(ride_1)
      expect(Ride.match_ride(ride_3.id)) .to include(ride_1)
    end
  end

end