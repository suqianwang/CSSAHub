Feature: Manage Rides
  View and edit rides
  
  Scenario: I want to see my rides
    Given I am logged in
	When I am on the profile page
	Then I should see my rides
	
  Scenario: I can see edit my rides
    Given I am logged in
	And a ride exists
	When I am on the edit page
	And I press Update Rides
	Then the ride should update

Scenario: Admin not edit rides
  Given I am an admin
  And a ride exists
  When I am on the edit page
  Then I should see 401
  
  Scenario: User can delete their own ride
    Given I am logged in
	And a ride exists
	When I am on the profile page
    When I click on the delete link
    Then the ride should be destroyed