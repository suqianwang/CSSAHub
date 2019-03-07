Feature: Passenger form
  Fill in passenger form

  Scenario: I am filling in passenger form
    Given I am on the passenger form page
    When I fill out the form
    Then My record should be stored in the database