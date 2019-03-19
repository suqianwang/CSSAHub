When("I view the Posts page") do
  visit posts_index_path
end

Then("I should see existing posts") do
  expect(page).to have_content('Posts')
end

When("I click on the remove post button") do
  click_button 'Delete'
end

Then("the post should be deleted") do
  expect(page).to have_no_content('postID')
end