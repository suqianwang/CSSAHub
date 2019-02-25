Given("I am on the create an account page") do
  visit "accounts/new"
end

When("I fill out the form") do
  fill_in "Username", :with => "bob"
  fill_in "Email", :with => "bob@tamu.edu"
  fill_in "Name", :with => "bob"
  fill_in "Password", :with => "bobpass"
  fill_in "Password confirmation", :with => "bobpass"
  click_button "Create Account"
end

Then("a new account should be created") do
  expect(page).to have_content("Account was successfully created.")
end