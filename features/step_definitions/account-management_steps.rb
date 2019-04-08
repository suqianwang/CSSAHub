Given("a user exists") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :user
end

Given ("I am on the Accounts page") do
  @initial_num_accounts = Account.count
  visit accounts_path
end

When("I click delete for a user") do
  expect(page).to have_content(@account.username)
  click_on("delete-" + @account.username)
  click_on("confirmDeletion-" + @account.username)
end

Then ("that user should not exist anymore") do
  expect(page).to have_no_content(@account.username)
end

Then("I should see all accounts") do
  expect(page.all('table tr').count).to eq(Account.count+1) #including header row
end

Then("I should see details for each account") do
  expect(page).to have_content(@account.username)
  if not @account.name.blank?
    expect(page).to have_content(@account.name)
  end
  expect(page).to have_content(@account.email)
  expect(page).to have_content(@account.created_at.strftime("%m/%d/%Y"))
end

Then("other users should still exist") do
  expect(Account.count).to eq(@initial_num_accounts-1)
end