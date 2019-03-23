RSpec.describe Ride, :type => :model do
  before do 
    @ride = FactoryBot.create :ride
  end
  
  describe '#account' do
    it { is_expected.to validate_associated :account }
  end
  
  describe '#role' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to allow_value("passenger").for(:role) }
    it { is_expected.to_not allow_value("invalid role").for(:role) }
  end
  
  describe '#locations' do
    it { is_expected.to validate_presence_of(:departure, :destination) }
    it { is_expected.to allow_value("Zachry").for(:departure, :destination) }
    it { is_expected.to_not allow_value("invalid location").for(:departure, :destination) }
  end
  
  describe '#dates' do
    it { is_expected.to validate_presence_of(:start_date, :end_date) }
  end
  
  describe '#date_order' do
    it 'validates end date is after begin date' do
      context 'with valid attributes' do
        @ride.start_date = Date.today+1
        @ride.end_date = Date.today+2
        expect(@ride).to be_valid
      end
      context 'with invalid attributes' do
        @ride.start_date = Date.today+2
        @ride.end_date = Date.today+1
      end
    end
    it 'validates that start_date is not today' do
      @ride.start_date = Date.today
      @ride.end_date = Date.today+1
    end
  end
  
  describe '#time' do
    it { is_expected.to validate_presence_of(:start_time, :end_time) }
  end
  
  describe '#time_order' do
    it 'validates end time is after begin time' do
      context 'with valid attributes' do
        @ride.start_time = Time.current
        @ride.end_time = Time.current+2
        expect(@ride).to be_valid
      end
      context 'with invalid attributes' do
        @ride.start_time = Time.current+2
        @ride.end_time = Time.current+1
      end
    end
  end
  
  describe '#seats' do
    it { is_expected.to validate_presence_of(:seats) }
    it { is_expected.to validate_inclusion_of :seats, in: 1..8 }
  end
end