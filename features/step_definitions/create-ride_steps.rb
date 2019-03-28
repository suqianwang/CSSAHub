require 'pry'

Given("I am logged in") do
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  within '#login-form' do
    click_button "Login"
  end
end

Given("I am on the new ride page") do
  visit new_ride_path
end

When("I select my role as {string}") do |string|
  find_by_id(string).click
  @role = string.downcase
end

When("I fill in the form") do
  @ride = FactoryBot.build_stubbed(:ride)
  select(@ride.departure, from: 'Depart From:')
  select(@ride.destination, from: 'Destination:')
  fill_in('ride_start_date', with: @ride.start_date)
  fill_in('ride_end_date', with: @ride.end_date)
  fill_in('ride_start_time', with: '8:00')
  fill_in('ride_end_time', with: '12:00')
  fill_in('ride_seats', with: @ride.seats)
end

When("I press Submit") do
  click_button "Create Ride"
end

Then("I should be on the rides home page") do
  expect(page).to have_current_path(rides_path)
end

Then("I should see the newly created ride") do
  expect(page.all('table#rides-table tr').count).to eq 2
end