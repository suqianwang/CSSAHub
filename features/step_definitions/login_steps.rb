Given("I am registered") do
  @account = Account.create(username: "bob", email: "bob@tamu.edu")
end

Given("I am on the home page") do
  visit home_index_path
end

When("I follow the sign in link") do
  click_button "Sign-in/Register"
end

When("I sign in") do
  nil #oauth mocking does this step for us
end

When("I visit the login page") do
  visit login_path
end

When("I open the navbar dropdown") do
  click_button "Welcome, #{@account.username}"
end

When("I click logout") do
  click_link "Logout"
end

Then("I should be redirected to the services page") do
  expect(page).to have_current_path(services_path)
end

Given("I am not registered") do
  @init_num_accounts = Account.count
end

Then("my account should be created") do
  expect(Account.count).to eq(@init_num_accounts+1)
end

Given("my account is archived") do
  @account.archived = true
  @account.save
end

Then("I should be redirected to the home page") do
  expect(page).to have_current_path(home_index_path)
end

Then("I should see a message saying my account is disabled") do
  expect(page).to have_content("Your account has been disabled.")
end

Given("I am registered as an admin") do
  @admin = Account.create(username: "bob", email: "bob@tamu.edu", isAdmin: true)
end

# When("I sign in with invalid credentials") do
#   pending # Write code here that turns the phrase above into concrete actions
# end