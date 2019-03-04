RSpec.describe Ride, :type => :model do
  describe '#type, #role' do
    it { is_expected.to validate_presence_of(:type, :role) }
    it { is_expected.to allow_value("transportation").for(:type) }
    it { is_expected.to allow_value("receiver").for(:role) }
    it { is_expected.to_not allow_value("invalid").for(:type, :role) }
  end
end