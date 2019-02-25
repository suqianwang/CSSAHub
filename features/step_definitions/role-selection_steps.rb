Given("I want to be a {string}") do |role|
  @role = role
end

When("I select my role") do
  visit new_ride_path
  choose @role
  click_button 'Create Ride'
  @actual_role = all('td').last.text
end

Then("a ride should be created with me as {string}") do |expected_role|
  expect(@actual_role).to eq(expected_role)
end