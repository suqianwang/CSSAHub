Then("I should see my rides") do
  expect(page).to have_content('Posted Rides')
end

When("I am on the edit page") do
   visit edit_ride_path(@ride)
end

When("I press Update Rides") do
  click_button "Update Ride"
end

Then("the ride should update") do
    expect(page).to have_content('Ride was successfully updated.')
end

Then("I should see 401") do
    expect(page).to have_content('401')
end

When("I click on the delete link") do
  click_link "Delete"
end

Then("the ride should be destroyed") do
    expect(page).to have_content('Ride was successfully destroyed.')
end

Then("I should get an error message for the ride") do
  # expect(page).to have_content('Field is missing or invalid in the form.')
end