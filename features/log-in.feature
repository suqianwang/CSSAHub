Feature: Log in
  As a user, I want to be able to enter my username and password to login to next page
  
  Scenario: I'm logging in
    Given I am in the log in page
    When I fill in my username, password and press Login button
    Then I should see a welcome message

  Scenario: I'm logging in with wrong information
    Given I am in the log in page
    When I fill in my username, wrong password and press Login button
    Then I should see Username or password is invalid

  Scenario: I'm logging out
    Given I am in the log in page
    When I fill in my username, password and press Login button
    And press log out
    Then I should be redirected to log in page
    
  Scenario: I am already logged in
    Given I am logged in
    When I visit the login page
    Then I should be redirected to the service hub page