When("I click on the show link") do
  click_link "Show"
end

Then("the ride should be shown") do
   expect(page).to have_content("Ride")
end