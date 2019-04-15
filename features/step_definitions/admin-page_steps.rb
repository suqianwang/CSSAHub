require 'pry'

Given("I am an admin") do
  @account = Account.create(username: "bob", email: "bob@tamu.edu", isAdmin: true)
  visit login_url
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
  @account = Account.create(username: "bob", email: "bob@tamu.edu", isAdmin: false)
  visit login_url
end

When("I visit admin page") do
  visit admin_index_path
end

Then("I will be redirected to the main hub") do
  expect(page).to have_content("Services")
end