Given("a ride exists") do
  visit new_ride_path
  find_by_id('Driver').click
  @ride = FactoryBot.build_stubbed(:ride)
  fill_in('ride_departure', with: @ride.departure)
  fill_in('ride_destination', with: @ride.destination)
  fill_in('ride_start_date', with: @ride.start_date)
  fill_in('ride_end_date', with: @ride.end_date)
  fill_in('ride_start_time', with: @ride.start_time)
  fill_in('ride_end_time', with: @ride.end_time)
  fill_in('ride_seats', with: @ride.seats)
  click_button "Create Ride"
  expect(page).to have_current_path(rides_path)
  expect(page.all('table#rides-table tr').count).to eq 2
end

When("I view the Rides page") do
  visit rides_path
end

Then("I should see existing posts") do
  expect(page).to have_content('Rides')
end

When("I click on the delete button") do
  click_link 'Delete'
end

Then("the post should be deleted") do
  expect(page).to have_no_content('Zachary')
end