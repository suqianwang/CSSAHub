Feature: Create an account
  Create a new account
  
  Scenario Outline: I am creating a new account
    Given I am on the create an account page
    When I fill out the form
    Then a new account should be created