RSpec.describe ApplicationController, :type => :controller do
before do
    @account = FactoryGirl.create(:account)
  end
  
  describe "session exists" do
    it "should get current session id" do
	  controller.session[:account_id] = @account.id
	  expect(controller.current_user).to eq(@account)
    end
  end
  
  describe "session does not exist" do
    it "should return nil" do
      controller.session[:account_id] = nil
	  expect(controller.current_user).to eq(nil)
    end
  end


end