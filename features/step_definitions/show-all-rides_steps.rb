require 'pry'

Then ("I am on the rides page") do
  visit rides_path
  expect(page).to have_content("All Rides Offers/Requests")
end

When ("I check the driver checkbox") do
  check('driver')
end

Then ("I click Refresh") do
  click_button "Refresh"
end

Then ("only offered rides will show") do
  expect(page).should_not have_content('Contact Passenger')
end

When ("I check the passenger checkbox") do
  check('passenger')
end

And ("I uncheck the driver checkbox") do
  uncheck('driver')
end

Then ("only requested rides will show") do
  expect(page).should_not have_content('Contact Driver')
end

When ("I click contact {string}") do |string|
  @role = string
  click_button "Contact #{@role}"
end

Then ("the {string} information will pop up") do |string|
  @role = string
  expect(page).to have_content("#{@role} Information")
end