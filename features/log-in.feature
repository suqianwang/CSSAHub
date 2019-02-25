Feature: Log in
  As a user, I want to be able to enter my username and password to login to next page
  
  Scenario: I'm logging in
    Given I am in the log in page
    When I fill in my username, password and press Login button
    Then I should see a welcome message