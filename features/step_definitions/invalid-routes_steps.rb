When("I visit an invalid route") do
  visit "/dog"
end

When("I visit an invalid route for accounts") do
  visit "/accounts/dog"
end

When("I visit an invalid route for rides") do
  visit "/rides/dog"
end