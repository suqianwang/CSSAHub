RSpec.describe Ride, :type => :model do
  describe '#role' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to allow_value("passenger").for(:role) }
    it { is_expected.to_not allow_value("invalid role").for(:role) }
  end
      
end