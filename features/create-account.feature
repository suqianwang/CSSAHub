Feature: Create an account
  Create a new account
  
  Scenario: I am creating a new account
    Given I am on the create an account page
    When I fill out the create account form
    Then a new account should be created
    
  Scenario: I am already logged in
    Given I am logged in
    When I visit the login page
    Then I should be redirected to the service hub page