Feature: Delete user
  Delete a user from the user list
  
  Scenario: I want to delete an account
    Given I am an admin
	Given a user exists
	Given I am on the Accounts page
	When I delete a user
	Then the user should not exist anymore