require 'pry'

RSpec.describe Ride, :type => :model do
  before do 
    @account = FactoryBot.build_stubbed(:account, :user)
    @ride = FactoryBot.build_stubbed(:ride, account: @account)
    # @ride.account = @account
  end
  
  describe '#account' do
    it { is_expected.to belong_to :account }
  end
  
  describe '#role' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to allow_value("passenger").for(:role) }
    it { is_expected.to_not allow_value("invalid role").for(:role) }
  end
  
  describe '#departure' do
    it { is_expected.to validate_presence_of :departure }
    # it { is_expected.to allow_value("Zachry").for(:departure) }
    # it { is_expected.to_not allow_value("invalid location").for(:departure) }
  end
  
  describe '#destination' do
    it { is_expected.to validate_presence_of :destination }
    # it { is_expected.to allow_value("Zachry").for(:destination) }
    # it { is_expected.to_not allow_value("invalid location").for(:destination) }
  end
  
  describe '#dates' do
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
  end
  
  describe '#date_order' do
    context 'with valid attributes' do
      it 'validates end date is on or after begin date' do
        @ride.start_date = (Date.today).strftime("%m/%d/%Y")
        @ride.end_date = (Date.today).strftime("%m/%d/%Y")
        expect(@ride).to be_valid
      end
      it 'validates that start_date is not before today' do
        @ride.start_date = (Date.today+1).strftime("%m/%d/%Y")
        @ride.end_date = (Date.today+2).strftime("%m/%d/%Y")
        expect(@ride).to be_valid
      end
    end
    context 'with invalid attributes' do
      it 'validates end date is on or after begin date' do
        @ride.start_date = (Date.today+2).strftime("%m/%d/%Y")
        @ride.end_date = (Date.today+1).strftime("%m/%d/%Y")
        expect(@ride).to_not be_valid
      end
      it 'validates that start_date is not before today' do
        @ride.start_date = (Date.today-1).strftime("%m/%d/%Y")
        @ride.end_date = (Date.today).strftime("%m/%d/%Y")
        expect(@ride).to_not be_valid
      end
    end
  end
  
  describe '#time' do
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :end_time }
  end
  
  describe '#time_order' do
    context 'with valid attributes' do
      it 'validates end time is after begin time' do
        @ride.start_time = Time.current
        @ride.end_time = Time.current+2
        expect(@ride).to be_valid
      end
    end
    context 'with invalid attributes' do
      it 'validates end time is after begin time' do
        @ride.start_time = Time.current+2
        @ride.end_time = Time.current+1
      end
    end
  end
  
  describe '#seats' do
    it { is_expected.to validate_presence_of(:seats) }
    it { is_expected.to validate_inclusion_of(:seats).in_range(1..8)}
  end
end