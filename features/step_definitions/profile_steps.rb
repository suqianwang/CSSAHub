When("I am on the profile page") do
  visit profile_index_path
end

Then("I should see my information") do
   page.should have_field("username", with: @account.username)
end