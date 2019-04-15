require 'pry'

When("I click on the match link") do
  click_link "Match"
end

Then("the ride should be shown") do
   expect(page).to have_content("Ride")
end
