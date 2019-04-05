Given("I am an admin") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :admin
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  within '#login-form' do
    click_button 'Login'
  end
end

Given("{string} exists on the admin page") do |string|
  @option = string
end

When("I view the admin page") do
  visit admin_index_path
end

Then("I should see {string} on the admin page") do |string|
  expect(page).to have_content('Dashboard')
end

Given("I want to go to the {string} page from the admin page") do |string|
  @option = string
  visit admin_index_path
end

When("I select the {string} on the admin page") do |string|
  click_link @option
end

Then("the site should navigate to the {string} page from the admin page") do |string|
  expect(page).to have_content(string)
end

Given("I am not an admin") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :user
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  within '#login-form' do
    click_button 'Login'
  end
end

When("I visit admin page") do
  visit admin_index_path
end

Then("I will be redirected to the main hub") do
  expect(page).to have_content("Services")
end