When("I visit an invalid route") do
  visit "/dog"
end

When("I visit an invalid route for accounts") do
  visit "/accounts/dog"
end

When("I visit an invalid route for rides") do
  visit "/rides/dog"
end

Then("I should be redirected to the home page") do
  expect(page).to have_current_path("/home/index")
end