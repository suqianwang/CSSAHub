require 'pry'

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
  find_by_id(string).click
  @role = string.downcase
end

Then("the {string} form should appear") do |string|
  expect(page).to have_css("#" + @role + "_form")
end

When("I fill in the form") do
  binding.pry
  @ride = FactoryBot.build_stubbed(:ride, account: @account)
  within('#' + @role + "_form") do
    select(@ride.departure, from: 'Depart From:')
    select(@ride.destination, from: 'Destination:')
    fill_in('start-date', with: @ride.start_date)
    fill_in('end-date', with: @ride.end_date)
    fill_in('start-time', with: @ride.start_time)
    fill_in('end-time', with: @ride.end_time)
    fill_in('seats', with: @ride.seats)
  end
end

When("I press Submit") do
  click_button "Create Ride"
end

Then("I should be on the ride's page") do
  binding.pry
  expect(page).to have_current_path(ride_url(Ride.last.id))
end

Then("I should see the details of my newly created ride") do
  expect(page).to have_content("Ride " + String(Ride.last.id))
end