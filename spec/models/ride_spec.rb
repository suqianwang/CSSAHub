require 'pry'

RSpec.describe Ride, :type => :model do
  before do
    @account = FactoryBot.build_stubbed(:account, :user)
    @ride = FactoryBot.build_stubbed(:ride, account: @account)
  end

  describe '#account' do
    it {is_expected.to belong_to :account}
  end

  describe '#role' do
    it {is_expected.to validate_presence_of(:role)}
    it {is_expected.to allow_value("passenger").for(:role)}
    it {is_expected.to_not allow_value("invalid role").for(:role)}
  end

  describe '#departure' do
    it do
      should validate_presence_of(:departure).
          with_message("Please select a valid departure location from Google Maps")
    end
    it {is_expected.to allow_value("Zachry Engineering Center, Spence Street, College Station, TX, USA").for(:departure)}
    # it { is_expected.to_not allow_value("invalid location").for(:departure) }
  end

  describe '#destination' do
    it do
      should validate_presence_of(:destination).
          with_message("Please select a valid destination location from Google Maps")
    end
    it {is_expected.to allow_value("Zachry Engineering Center, Spence Street, College Station, TX, USA").for(:destination)}
    # it { is_expected.to_not allow_value("invalid location").for(:destination) }
  end

  describe '#dates' do
    it do
      should validate_presence_of(:start_date).
          with_message("Please select a departure date")
      should_not allow_value(1.day.ago).
          for(:start_date)
    end
  end

  describe '#start_date=' do
    it 'fix value' do
      r = Ride.new
      r.start_date = '08/16/2020'
      expect(r.start_date).to eq("2020-08-16")
    end
  end

  describe '#end_date=' do
    it 'fix value' do
      r = Ride.new
      r.start_date = '08/16/2020'
      expect(r.start_date).to eq("2020-08-16")
    end
  end

  #will be added after end_date is implemented
  # describe '#date_order' do
  #   context 'with valid attributes' do
  #     it 'validates end date is on or after begin date' do
  #       @ride.start_date = (Date.today).strftime("%m/%d/%Y")
  #       @ride.end_date = (Date.today).strftime("%m/%d/%Y")
  #       expect(@ride).to be_valid
  #     end
  #     it 'validates that start_date is not before today' do
  #       @ride.start_date = (Date.today+1).strftime("%m/%d/%Y")
  #       @ride.end_date = (Date.today+2).strftime("%m/%d/%Y")
  #       expect(@ride).to be_valid
  #     end
  #   end
  #   context 'with invalid attributes' do
  #     it 'validates end date is on or after begin date' do
  #       @ride.start_date = (Date.today+2).strftime("%m/%d/%Y")
  #       @ride.end_date = (Date.today+1).strftime("%m/%d/%Y")
  #       expect(@ride).to_not be_valid
  #     end
  #     it 'validates that start_date is not before today' do
  #       @ride.start_date = (Date.today-1).strftime("%m/%d/%Y")
  #       @ride.end_date = (Date.today).strftime("%m/%d/%Y")
  #       expect(@ride).to_not be_valid
  #     end
  #   end
  # end

  describe '#time' do
    it do
      should validate_presence_of(:start_time).
          with_message("Please enter a starting departure time")
    end
    it do
      should validate_presence_of(:end_time).
          with_message("Please enter a ending departure time")
    end
  end

  describe '#time_order' do
    context 'with valid attributes' do
      it 'validates end time is after begin time' do
        @ride.start_time = Time.current
        @ride.end_time = Time.current + 2
        expect(@ride).to be_valid
      end
    end
    context 'with invalid attributes' do
      it 'validates end time is after begin time' do
        @ride.start_time = Time.current + 2
        @ride.end_time = Time.current + 1
      end
    end
  end

  describe '#seats' do
    it {is_expected.to validate_presence_of(:seats).with_message(/enter a seat number/)}
    it {is_expected.to validate_inclusion_of(:seats).in_range(1..8).with_message(/between 1-8/)}
  end


  describe 'In Range' do
    location1 = Ride.new
    location1.departure_lat = 0
    location1.departure_lon = 0
    location1.destination_lat = 0
    location1.destination_lon = 0
    location2 = Ride.new
    location2.departure_lat = 0
    location2.departure_lon = 5
    location2.destination_lat = 0
    location2.destination_lon = 5
    location3 = Ride.new
    location3.departure_lat = 0
    location3.departure_lon = 6
    location3.destination_lat = 0
    location3.destination_lon = 6
    location4 = Ride.new
    location4.departure_lat = 0
    location4.departure_lon = 4
    location4.destination_lat = 0
    location4.destination_lon = 4
    it 'Test departure in range helper function' do
      expect(Ride.departure_in_range(location1, location2, 300)).to be_falsey
      expect(Ride.departure_in_range(location1, location3, 300)).to be_falsey
      expect(Ride.departure_in_range(location1, location4, 300)).to be_truthy
    end
    it 'Test arrival in range helper function' do
      expect(Ride.destination_in_range(location1, location2, 300)).to be_falsey
      expect(Ride.destination_in_range(location1, location3, 300)).to be_falsey
      expect(Ride.destination_in_range(location1, location4, 300)).to be_truthy
    end
  end

end