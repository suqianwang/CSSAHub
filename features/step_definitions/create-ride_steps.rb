require 'pry'

Given("I am logged in") do
  @account = Account.create(username: "bob", email: "bob@tamu.edu")
  visit login_path
end

Given("A matching ride exists") do
  @matching_ride = FactoryBot.create(:ride)
end

Given("A passenger ride exists that is not a match because of capacity") do
  @p_matching_ride = FactoryBot.create(:ride, :seats => 5, :role =>'passenger')
end


Given("A driver ride exists that is not a match because of capacity") do
  @d_matching_ride = FactoryBot.create(:ride, :seats => 1, :role => 'driver')
end

Given("I am on the new ride page") do
  visit new_ride_path
end

When("I select my role as {string}") do |string|
  find_by_id(string).click
  @role = string.downcase
end

When("I fill in the form") do
  @ride_params = { departure: "Zachry Engineering Center, Spence Street, College Station, TX, USA", destination: "George Bush Intercontinental Airport (IAH), North Terminal Road, Houston, TX, USA", start_date: (Date.today+1).strftime("%m/%d/%Y"), start_time: "08:00", end_time: "12:00", seats: 2 }
  fill_in('ride_departure', with: @ride_params[:departure])
  fill_in('ride_destination', with: @ride_params[:destination])
  fill_in('ride_start_date', with: @ride_params[:start_date])
  fill_in('ride_start_time', with: @ride_params[:start_time])
  fill_in('ride_end_time', with: @ride_params[:end_time])
  fill_in('ride_seats', with: @ride_params[:seats])
end

When("I fill in the form with a matching ride") do
  # @ride_params = { departure: "Zachry Engineering Center, Spence Street, College Station, TX, USA", destination: "George Bush Intercontinental Airport (IAH), North Terminal Road, Houston, TX, USA", start_date: (Date.today).strftime("%m/%d/%Y"), start_time: "08:00", end_time: "12:00", seats: 2 }
  fill_in('ride_departure', with: @matching_ride.departure)
  fill_in('ride_destination', with: @matching_ride.destination)
  fill_in('ride_start_date', with: @matching_ride.start_date)
  fill_in('ride_start_time', with: @matching_ride.start_time)
  fill_in('ride_end_time', with: @matching_ride.end_time)
  fill_in('ride_seats', with: @matching_ride.seats)
end


When("I fill in the form wrongly") do
  @ride = FactoryBot.build_stubbed(:ride)
  @wrong_fields = 10
  fill_in('ride_departure', with: nil)
  fill_in('ride_destination', with: nil)
  fill_in('ride_start_date', with: Date.today-1)
  fill_in('ride_start_time', with: '01/01/00')
  fill_in('ride_end_time', with: nil)
end

When("I press Submit") do
  click_button "Create Ride"
end

Then("I should be on the auto-matching page") do
  expect(page).to have_content("Auto-Matched Rides")
end

Then("I should see no match") do
  expect(page).to have_content("Sorry")
end

When ("I press follow the link View all rides") do
  click_link("View all rides")
end

Then ("I should be on the rides page") do
  expect(page).to have_content("All Rides Offers/Requests")
end

Then("I should see errors for each wrong field") do
  expect(page).to have_content("#{@number_errors} errors")
end
