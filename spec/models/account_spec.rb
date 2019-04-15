require 'pry'

RSpec.describe Account, :type => :model do
	before(:each) do
		@auth = OmniAuth.config.mock_auth[:google_oauth2]
	end
	
	describe "#email" do
		it { is_expected.to validate_presence_of :email }
		it { is_expected.to allow_value("bob@tamu.edu").for(:email) }
		it { is_expected.to_not allow_value("bob@gmail.com").for(:email) }
		it { is_expected.to_not allow_value("bob@tamu.edu.com").for(:email) }
	end
	
	describe "self.from_omniauth" do
		it "assigns existing accounts matching auth to @account" do
			account = Account.create(username: "bob", email: "bob@tamu.edu")
			matching_account = Account.from_omniauth(@auth)
			expect(matching_account).to eq(account)
		end
		it "assigns existing accounts matching auth to @account if matching account doesn't yet exist" do
			matching_account = Account.from_omniauth(@auth)
			expect(matching_account.email).to eq(@auth.info.email)
		end
		it "creates a new account to match auth if match doesn't exist" do
			assert_difference "Account.count" do
				Account.from_omniauth(@auth)
			end
		end
	end
end