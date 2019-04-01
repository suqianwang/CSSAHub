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
  
      assert_redirected_to account_url(Account.last)
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
       #assert_difference('Account.count', -1) do
         #delete :destroy, id: @account
		 #delete account_url(@account.id)
       #end
       #assert_redirected_to accounts_url
	   
      expect {
	   delete :destroy, params: {id: new_account.to_param}
      }.to change(Account, :count).by(-1)
	  end
 end
end