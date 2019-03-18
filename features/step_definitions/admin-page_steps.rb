Given("I am an admin") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :admin
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button 'Login'
end

Given("{string} exists on the admin page") do |string|
  @option = string
end

When("I view the admin page") do
  visit admin_index_path
end

Then("I should see {string} on the admin page") do |string|
  expect(page).to have_content('Admin Page')
end

Given("I want to go to the {string} page from the admin page") do |string|
  @option = string
  visit admin_index_path
end

When("I select the option on the admin page") do
  click_link @option
  visit accounts_path
end

Then("the site should navigate to the {string} page from the admin page") do |string|
  expect(page).to have_content('Accounts')
end

Given("I am not an admin") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :user
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button 'Login'
end

When("I visit admin page") do
  visit admin_index_path
end

Then("I will be redirected to rides") do
  expect(page).to have_content("Ride")
end