Feature: Create the passenger form
  As a passenger
  So that I can enter my information
  I want to see a form that has fields that I can fill out ride information

  Scenario: I did not logged in
    Given I am not logged in
    When I visit the passenger page
    Then I should be redirect to log in page with passenger message

  Scenario: I'm creating a ride request
    Given I am in the passenger page
    When I fill in my destination, departure date, departure time as a range, a checkbox to indicate the departure range is all day and number of people who need a ride
    Then I should see creation successful message and be on rides page




