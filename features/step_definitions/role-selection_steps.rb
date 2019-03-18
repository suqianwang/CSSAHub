Given("I want to be a {string}") do |role|
  require 'factory_bot_rails'
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button 'Login'
  visit new_ride_path
  @role = role
end

When("I select my role") do
  choose @role
  click_button 'Create Ride'
end

Then("a form should be created with me as {string}") do |expected_role|
  expect(page).to have_content(expected_role)
end