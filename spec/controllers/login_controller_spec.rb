RSpec.describe LoginController, :type => :controller do
  before do
    @account = FactoryBot.create :account, :user
	  @admin = FactoryBot.create :account, :admin
  end
  
  describe "GET #index" do
    context "user is logged in" do
      it "should redirect to service hub page" do
        session[:account_id] = @account.id
        session['login'] = @account.username
        get :index
        expect(response).to redirect_to(services_path)
      end
    end
  end
  
#   describe "login with correct information" do
#     it "should login" do
# 	  post :create,  params: { password: @account.password, username: @account.username  }
# 	  expect(controller.session[:account_id]).to eq(@account.id)
# 	  expect(controller.session['login']).to eq(@account.username)
# 	  expect(response).to redirect_to(services_path)
#     end
#   end
  
#     describe "login with admin information" do
#     it "should login" do
# 	  post :create,  params: { password: @admin.password, username: @admin.username  }
# 	  expect(controller.session[:account_id]).to eq(@admin.id)
# 	  expect(controller.session['login']).to eq(@admin.username)
# 	  expect(response).to redirect_to(admin_index_path)
#     end
#   end
  
#   describe "login with incorrect password" do
#     it "should not login and return errors" do
# 	  post :create,  params: { password: @account.password + "aaa", username: @account.username }
#     expect(controller.session[:account_id]).to be_nil
# 	  expect(response).to render_template :index
#     end
#   end

# describe "login with incorrect username" do
#   it "should not login and return errors" do
#     post :create,  params: { password: @account.password, username: @account.username + "aaa" }
#     expect(controller.session[:account_id]).to be_nil
#     expect(response).to render_template :index
#   end
# end


  
  describe "logout" do
    it "#DESTROY session" do
	  post :destroy
	  expect(session['login']).to eq(nil)
	  expect(response).to redirect_to(home_index_path) 
    end
  end

  
  #   describe "login with archive account" do
  #   it "should not login" do
	 # @archive_account = FactoryBot.create :account, :archived_user
	 # post :create,  params: { password: @archive_account.password, username: @archive_account.username }
  #     expect(response).to render_template :index
  #   end
  # end
  
end