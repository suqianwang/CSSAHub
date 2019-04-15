RSpec.describe Account, :type => :model do
	
	describe "#email" do
		it { is_expected.to validate_presence_of :email }
		it { is_expected.to allow_value("bob@tamu.edu").for(:email) }
		it { is_expected.to_not allow_value("bob@gmail.com").for(:email) }
		it { is_expected.to_not allow_value("bob@tamu.edu.com").for(:email) }
	end
end