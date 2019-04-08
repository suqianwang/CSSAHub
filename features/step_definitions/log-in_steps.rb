Given("I am in the log in page") do
  require 'factory_bot_rails'
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
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

Then("I should be redirected to log in page") do
  expect(page).to have_content("Login")
end

When("I visit the login page") do
  visit login_index_path
end

Then("I should be redirected to the service hub page") do
  expect(page).to have_current_path(services_path)
end