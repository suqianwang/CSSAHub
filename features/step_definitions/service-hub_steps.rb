When("I view the hub page") do
  visit services_path
end

Then("I should see {string}") do |string|
  expect(page).to have_link(@service)
end

Given("I want to go to the {string} page") do |string|
  @service = string
end

When("I select the service") do
  visit services_path
  click_link @service
end

Then("I should be redirected to the {string} page") do |string|
  expect(page).to have_current_path(polymorphic_path(string))
end

Then("I should be redirected to the admin page") do
  expect(page).to have_current_path(admin_index_path)
end