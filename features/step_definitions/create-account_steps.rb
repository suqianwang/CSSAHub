Given("I am on the create an account page") do
  visit "accounts/new"
end

When("I fill out the create account form") do
  fill_in "Username", :with => "bob"
  fill_in "Email", :with => "bob@tamu.edu"
  fill_in "Name", :with => "bob"
  fill_in "Password", :with => "bobpass"
  fill_in "Password confirmation", :with => "bobpass"
  check "account_terms_and_conditions"
  click_button "Create Account"
end

Then("a new account should be created") do
  expect(page).to have_content("Account was successfully created.")
end

When("I fill out the create account form wrong") do
  fill_in "Username", :with => "bob"
  fill_in "Email", :with => "bob@tamu.edu"
  fill_in "Name", :with => "bob"
  fill_in "Password", :with => "bobpass"
  click_button "Create Account"
end

Then("a new account should not be created") do
  expect(page).to_not have_content("Account was successfully created.")
end