Given("I am logged in") do
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button "Login"
end

Given("I am on the new ride page") do
  visit new_ride_path
end

When("I select my role as {string}") do |string|
  @role = string
  click_button "Submit"
end

Then("the passenger form should appear") do
  expect(page).to have_content("Request Ride")
end

When("I fill in the form") do
 @ride = FactoryBot.create(:ride)
 select(@ride.departure, from: 'Departure')
 select(@ride.destination, from: 'Destination')
 fill_in('Start Date', with: @ride.start_date)
 fill_in('End Date', with: @ride.end_date)
 fill_in('Start Time', with: @ride.start_time)
 fill_in('End Time', with: @ride.end_time)
 select(@ride.seats, from: 'seats')
end

When("I press Submit") do
  click_button "Submit"
end

Then("I should be on the ride's page") do
  expect(page).to have_title('show')
end

Then("I should see the details of my newly created ride") do
  @ride_id = find('ride_id').value
  expect(@ride_id).to_eq @ride.id
end