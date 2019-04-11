Given("I am in the log in page") do
  require 'factory_bot_rails'
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
end

Given("I am on the login page") do
  visit login_index_path
end

Given("I am an admin user") do
  @account = FactoryBot.create :account, :admin
end

Given("I am an archived user") do
  @account = FactoryBot.create :account, :archived_user
end

When("I fill in my username, password and press Login button") do
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  within '#login-form' do
    click_button 'Login'
  end
end

Then("I should see a welcome message") do
  within ('.dropdown button.dropdown-toggle') do
    expect(page).to have_content 'Welcome'
  end
  expect(page).to have_content("Logged in!")
end

When("I fill in my username, wrong password and press Login button") do
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password + "1"
  within '#login-form' do
    click_button 'Login'
  end
end

Then("I should see Username or password is invalid") do
  expect(page).to have_content("Username or password is invalid")
end

When("press log out") do
  click_link 'Logout'
end

When("I visit the login page") do
  visit login_index_path
end

Then("I should be redirected to the service hub page and see a message") do
  expect(page).to have_current_path(services_path)
  expect(page).to have_content("Logged in!")
end

Then("I should be redirected to the admin page") do
  expect(page).to have_current_path(admin_index_path)
end

Then("I should be redirected to log in page") do
  expect(page).to have_current_path(login_index_path)
end

Then("I should see an archive notification") do
  expect(page).to have_content("Your account has been disabled. Please contact an administrator for assistance.")
end