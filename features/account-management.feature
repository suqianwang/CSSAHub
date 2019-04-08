Feature: Manage user accounts
  View/Remove user accounts as an admin

  Scenario: I want to view all users
    Given I am an admin
    And a user exists
    When I am on the Accounts page
    Then I should see all accounts
    And I should see details for each account
  
  Scenario: I want to delete an account
    Given I am an admin
    And a user exists
  	And I am on the Accounts page
  	When I click delete for a user
  	Then that user should not exist anymore
  	But other users should still exist
	
  Scenario: I am not an admin
    Given I am logged in
    When I am on the Accounts page
    Then I should be redirected to the service hub page