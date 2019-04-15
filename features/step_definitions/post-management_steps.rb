Given("a ride exists") do
  require 'factory_bot_rails'
  @ride = FactoryBot.create(:ride, account: @account)
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