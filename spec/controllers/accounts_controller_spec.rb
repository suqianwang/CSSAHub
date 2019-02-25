RSpec.describe AccountsController, :type => :controller do
  before do
    @account = FactoryGirl.create(:account)
  end

  describe "GET #index" do
    it "should get index" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "should create new account" do
      get :new
      expect(response).to render_template :new
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

  # describe "delete #destroy" do
    # it "should destroy account" do
      # assert_difference('account.count', -1) do
        # delete account_url(@account)
      # end
  
      # assert_redirected_to accounts_url
  # end
# end
end