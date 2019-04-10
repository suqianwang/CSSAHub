When("I submit a new name") do
  fill_in "Name", :with => "Bob"
  click_button "Update My Profile"
end

When("I fill in password") do
  fill_in "New Password", :with => "newpass"
end

When("I correctly fill in confirmation") do
  fill_in "password_confirmation", :with => "newpass"
end

When("I incorrectly fill in confirmation") do
  fill_in "password_confirmation", :with => "wrongpass"
end

When("I click update") do
  click_button "Update My Profile"
end

Then("my name should change") do
  @account.name == "Bob"
end

Then("my password should change") do
  @account.password == "newpass"
end

Then("my password should not change") do
  @account.password != "wrongpass"
end