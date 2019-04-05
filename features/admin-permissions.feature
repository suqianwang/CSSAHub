Feature: Restore and archive user
  Restore and delete a user from the user list
  
  Scenario: I want to archive an account
    Given I am an admin
	Given a user exists
	Given I am on the Accounts page
	When I archive a user
	Then the user should not be shown on the page
	
  Scenario: I want to restore an account
    Given I am an admin
	And an archived user exists
	And I am on the Archive page
	When I restore a user
	Then the user should not be shown on the page
	
  Scenario: I want to archive an account as a nonadmin
    Given I am not an admin
	When I visit the accounts page
	Then I will be redirected to the main hub
	
  Scenario: I want to restore an account as a nonadmin
    Given I am not an admin
	When I visit the archive page
	Then I will be redirected to the main hub