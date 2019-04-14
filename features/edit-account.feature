Feature: Edit account information
  Edit my own account information

  Scenario: I want to change my name
    Given I am logged in
	And I am on the profile page
	When I submit a new name
	Then my name should change
	