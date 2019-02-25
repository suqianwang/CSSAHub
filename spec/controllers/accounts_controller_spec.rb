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
        post :create,  params: { account: { email: @account.email, name: @account.name, password: 'secret', password_confirmation: 'secret', username: @account.username } }
      end
  
      assert_redirected_to account_url(Account.last)
    end
  end

  # describe "GET #show" do
  #   it "should show account" do
  #     get show_account_url(@account)
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "shows edit page" do
  #     get edit_account(@account)
  #     expect(response).to render_template :edit
  #   end
  # end

  # describe "PUT #update" do
  #   it "should update account" do
  #     patch account_url(@account), params: { account: { email: @account.email, name: @account.name, password: 'secret', password_confirmation: 'secret', username: @account.username } }
  #     assert_redirected_to account_url(@account)
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "should destroy account" do
  #     assert_difference('Account.count', -1) do
  #       delete account_url(@account)
  #     end
  
  #     assert_redirected_to accounts_url
  # end
end
