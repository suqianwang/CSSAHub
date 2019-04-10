Feature: Edit account information
  Edit my own account information

  Scenario: I want to change my name
    Given I am logged in
	And I am on the profile page
	When I submit a new name
	Then my name should change
	
  Scenario: I want to change my password
    Given I am logged in
	And I am on the profile page
	When I fill in password
	And I correctly fill in confirmation
	And I click update
	Then my password should change
	
  Scenario: I want to change my password incorrectly
    Given I am logged in
	And I am on the profile page
	When I fill in password
	And I incorrectly fill in confirmation
	And I click update
	Then my password should not change