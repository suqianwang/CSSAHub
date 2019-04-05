require 'factory_bot_rails'
Given("a user exists") do
  @account = FactoryBot.create :account, :user
end

Given("an archived user exists") do
  @account = FactoryBot.create :account, :archived_user
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

When("I archive a user") do
  expect(page).to have_content(@account.username)
  click_on("archive-" + @account.username)
  click_on("confirmArchive-" + @account.username)
end

When ("I visit the accounts page") do
  visit accounts_path
end

When ("I visit the archive page") do
  visit archive_accounts_path
end

Then ("the user should not be shown on the page") do
  expect(page).to have_no_content(@account.username)
end