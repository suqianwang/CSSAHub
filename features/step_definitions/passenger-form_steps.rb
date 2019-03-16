Given("I am in the driver page") do
  visit "driver"
end


When("I fill in my destination, departure date, departure time as a range, a checkbox to indicate the departure range is all day and capacity") do
  select "Zachry", :from => "depart_from"
  select "HEB", :from => "destination"
  fill_in "Departure Date", with: "2014/01/01"
  select "12 AM", :from => "start-departure-time"
  select "02 AM", :from => "end-departure-time"
  fill_in "How many seats are available?", :with => "2"
  click_button "Submit Ride"
end

Then("I should see ride creation successful message and be on rides page") do
  expect(page).to have_content("Success!")
end

