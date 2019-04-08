require 'pry'

Given("I am logged in") do
  @account = FactoryBot.create(:account, :user)
  visit login_index_path
  fill_in "Username", :with => @account.username
  fill_in "Password", :with => @account.password
  within '#login-form' do
    click_button "Login"
  end
end

Given("I am on the new ride page") do
  visit new_ride_path
end

When("I select my role as {string}") do |string|
  find_by_id(string).click
  @role = string.downcase
end

When("I fill in the form") do
  @ride_params = { departure: "Zachry", destination: "IAH", start_date: (Date.today).strftime("%m/%d/%Y"), end_date: (Date.today+1).strftime("%m/%d/%Y"), start_time: "8:00", end_time: "12:00", seats: 2 }
  fill_in('ride_departure', with: @ride_params[:departure])
  fill_in('ride_destination', with: @ride_params[:destination])
  fill_in('ride_start_date', with: @ride_params[:start_date])
  fill_in('ride_end_date', with: @ride_params[:end_date])
  fill_in('ride_start_time', with: @ride_params[:start_time])
  fill_in('ride_end_time', with: @ride_params[:end_time])
  fill_in('ride_seats', with: @ride_params[:seats])
end

When("I fill in the form wrongly") do
  @ride = FactoryBot.build_stubbed(:ride)
  @wrong_fields = 10
  fill_in('ride_departure', with: nil)
  fill_in('ride_destination', with: nil)
  fill_in('ride_start_date', with: Date.today-1)
  fill_in('ride_end_date', with: "hello")
  fill_in('ride_start_time', with: '01/01/00')
  fill_in('ride_end_time', with: nil)
  fill_in('ride_seats', with: -1)
end

When("I press Submit") do
  click_button "Create Ride"
end

Then("I should be on the rides home page") do
  expect(page).to have_current_path(rides_path)
end

Then("I should see the newly created ride") do
  expect(page.all('table#rides-table tr').count).to eq 2
end

Then("I should see errors for each wrong field") do
  expect(page).to have_content("#{@number_errors} errors")
end