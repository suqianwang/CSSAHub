RSpec.describe AccountsController, :type => :controller do
  before do
    @account = FactoryBot.create :account, :user
	  @admin = FactoryBot.create :account, :admin
  end

  describe "GET #index" do
    it "should get index for admin" do
	  login(@admin)
      get :index
      expect(response).to render_template :index
    end
  end
  
  describe "GET #index" do
    it "should redirect to rides" do
	  login(@account)
      get :index
      expect(response).to redirect_to services_path
    end
  end

  describe "GET #new" do
    context "user is not logged in" do
      it "should render the new account form" do
        session[:account_id] = nil
        get :new
        expect(response).to render_template :new
      end
    end
    context "user is logged in" do
      it "should redirect to the service hub page" do
        session[:account_id] = @account.id
        session['login'] = @account.username
        get :new
        expect(response).to redirect_to(services_path)
      end
    end
  end

  describe "POST #create" do
    it "saves new account" do
      assert_difference 'Account.count' do
        post :create,  params: { account: { email: 'bob@tamu.edu', name: 'bob', password: 'secret', password_confirmation: 'secret', username: 'bo' } }
      end
  
      assert_redirected_to login_index_path
    end
  end
  
  describe "POST #create fail" do
    it "create new account returns error" do
        post :create,  params: { account: { email: nil, name: 'bob', password: 'secret', password_confirmation: 'secret', username: 'bo' } }
      #end
	  get :new
	  expect(response).to render_template('new')
    end
  end

  # describe "get #show" do
    # it "should show account" do
      # get show_account_url(@account)
      # expect(response).to have_http_status(:success)
    # end
  # end

  # describe "get #edit" do
    # it "shows edit page" do
      # get edit_account(@account)
      # expect(response).to render_template :edit
    # end
  # end

  #

  describe "delete #destroy" do
     it "should destroy account" do
	 new_account = FactoryBot.create :account, :user
	  login(@admin)
	   patch :destroy, params: { account: { id: new_account.id } }
	  end
  end
  
  describe "restore" do
     it "should allow account to work again" do
	 new_account = FactoryBot.create :account, :archived_user
	  login(@admin)
	   get :restore, params: { id: new_account.id }
	  end
  end
  
  describe "archive page" do
     it "should show a list of archived accounts" do
	   new_account = FactoryBot.create :account, :archived_user
	   login(@admin)
	   get :archive
	   expect(assigns(:accounts).count).to eq(1)
	end
  end
  
  describe "archive page" do
     it "should not allow a user to see archive list" do
	   new_account = FactoryBot.create :account, :archived_user
	   login(@account)
	   get :archive
       expect(response).to redirect_to services_path
	end
  end
  
end