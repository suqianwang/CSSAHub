Given("I am on the passenger form page") do
  visit "passengers/new"
end

When("I fill out the form") do
  select "Zachry Engineering Complex", :from => "Depart from"
  select "HEB", :from => "Destination"
  select "", :from => "Departure Date From"
  select "", :from => "Departure Date To"
  select "", :from => "Departure Time From"
  select "", :from => "Departure Time To"
  fill_in "How many passengers want to ride?", :with => "2"
  click_button "Create Request"
end

Then("My record should be stored in the database") do
  expect(page).to have_content("We received your request!")
end