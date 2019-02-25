Given("I am in the log in page") do
  require 'factory_girl_rails'
  @account = FactoryGirl.create(:account)
  Account.all.each do |user|
    puts user.username
  end
  visit login_index_path
end

When("I fill in my username, password and press Login button") do

  fill_in "Username", :with => @account.username
  puts @account.username
  fill_in "Password", :with => @account.password
  puts @account.password
  click_button 'Login'

end

Then("I should see a welcome message") do
  expect(page).to have_selector(:css,"p#welcome-message")
end

