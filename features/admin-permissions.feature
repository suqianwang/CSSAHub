Feature: Restore and delete user
  Restore and delete a user from the user list
  
  Scenario: I want to delete an account
    Given I am an admin
	Given a user exists
	Given I am on the Accounts page
	When I delete a user
	Then the user should not be shown on the page
	
  Scenario: I want to restore an account
    Given I am an admin
	And an archived user exists
	And I am on the Archive page
	When I restore a user
	Then the user should not be shown on the page