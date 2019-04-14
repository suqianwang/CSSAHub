When("I submit a new name") do
  fill_in "Name", :with => "Bob"
  click_button "Update My Profile"
end

When("I click update") do
  click_button "Update My Profile"
end

Then("my name should change") do
  @account.name == "Bob"
end