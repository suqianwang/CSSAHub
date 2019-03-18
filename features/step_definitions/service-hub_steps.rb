Given("{string} is available to me") do |string|
  require 'factory_bot_rails'
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button 'Login'
  @service = string
end

When("I view the hub page") do
  visit services_path
end

Then("I should see {string}") do |string|
  expect(page).to have_link(@service)
end

Given("I want to go to the {string} page") do |string|
  require 'factory_bot_rails'
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  click_button 'Login'
  @service = string
end

When("I select the service") do
  visit services_path
  expect(page).to have_content("Services")
  click_link @service
end

Then("the site should navigate to the {string} page") do |string|
  expect(page).to have_current_path(polymorphic_path(string))
end