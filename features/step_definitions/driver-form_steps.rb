Given("I am not logged in") do
end

When("I visit the driver page") do
  visit driver_path
end

Then("I should be redirect to log in page") do
  expect(page).to have_content("Please log in before creating driver form")
end

Given("I am in the driver page") do
  require 'factory_bot_rails'
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button 'Login'
  visit driver_path
end


When("I fill in my destination, departure date, departure time as a range, a checkbox to indicate the departure range is all day and number of people who need a ride") do
  select "Zachry", :from => "depart_from"
  select "HEB", :from => "destination"
  fill_in "Departure Date", with: "2014/01/01"
  select "12 AM", :from => "start-departure-time"
  select "02 AM", :from => "end-departure-time"
  fill_in "How many passengers want to ride?", :with => "2"
  click_button "Submit Request"
end

Then("I should see ride creation successful message and be on rides page") do
  expect(page).to have_content("Success!")
end

