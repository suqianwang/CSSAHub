Given("a user exists") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :user
end

Given("the user is archived") do
  @account.archived = true
end

Given ("I am on the Accounts page") do
  visit accounts_path
end

Given ("I am on the Archive page") do
  visit archive_accounts_path
end

When("I restore a user") do
  expect(page).to have_content(@account.username)
  click_on("restore-" + @account.username)
  click_on("confirmRestore-" + @account.username)
end

When("I delete a user") do
  expect(page).to have_content(@account.username)
  click_on("delete-" + @account.username)
  click_on("confirmDeletion-" + @account.username)
end

Then ("Then the user should not be shown on the page") do
  expect(page).to have_no_content(@account.username)
end