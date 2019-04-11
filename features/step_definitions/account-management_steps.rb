Given("a user exists") do
  require 'factory_bot_rails'
  @account = FactoryBot.create :account, :user
end

Given("an archived user exists") do
  @account = FactoryBot.create :account, :archived_user
end

Given ("I am on the Active Accounts page") do
  @initial_num_accounts = Account.count
  visit accounts_path
end

Given ("I am on the Archived Accounts page") do
  @initial_num_accounts = Account.count
  visit archive_accounts_path
end

When("I click archive for a user") do
  expect(page).to have_content(@account.username)
  click_on("archive-" + @account.username)
  click_on("confirmArchive-" + @account.username)
end

When("I click restore for a user") do
  expect(page).to have_content(@account.username)
  click_on("restore-" + @account.username)
  click_on("confirmRestore-" + @account.username)
end

Then ("the user should not be shown on the page") do
  expect(page).to have_no_content(@account.username)
end

Then("I should see all active accounts") do
  @active_accounts = Account.where(:archived == false)
  expect(page.all('table tr').count).to eq(@active_accounts.count) #+1 including header row; -1 admin should not show up
end

Then("I should see details for each account") do
  expect(page).to have_content(@account.username)
  if not @account.name.blank?
    expect(page).to have_content(@account.name)
  end
  expect(page).to have_content(@account.email)
  expect(page).to have_content(@account.created_at.strftime("%m/%d/%Y"))
end