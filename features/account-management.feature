Feature: Manage user accounts
  View/Remove user accounts as an admin

  Scenario: I want to view all users
    Given I am an admin
    And a user exists
    When I am on the Active Accounts page
    Then I should see all active accounts
    And I should see details for each account
  
  Scenario: I want to archive an account
    Given I am an admin
    And a user exists
  	And I am on the Active Accounts page
  	When I click archive for a user
  	Then the user should not be shown on the page
	
  Scenario: I want to restore an account
	Given I am an admin
    And an archived user exists
  	And I am on the Archived Accounts page
  	When I click restore for a user
  	Then the user should not be shown on the page
	
  Scenario: I am not an admin
    Given I am logged in
    When I am on the Active Accounts page
    Then I should be redirected to the service hub page and see a message
    And I am on the Archived Accounts page
    Then I should be redirected to the service hub page and see a message
