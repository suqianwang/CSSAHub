Feature: Create the driver form
  As a driver
  So that I can enter my information
  I want to see a form that has fields that I can fill out ride information


  Scenario: I'm creating a ride request
    Given I am in the driver page
    When I fill in my destination, departure date, departure time as a range, a checkbox to indicate the departure range is all day and capacity
    Then I should see creation successful message and be on rides page


