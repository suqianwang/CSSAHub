Given("a user exists") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :user
end

Given ("I am on the Accounts page") do
  visit accounts_path
end

When("I delete a user") do
  expect(page).to have_content(@account.username)
  click_on(@account.username)
  click_on("confirmDeletion-" + @account.username)
end

Then ("the user should not exist anymore") do
  expect(page).to have_no_content(@account.username)
end