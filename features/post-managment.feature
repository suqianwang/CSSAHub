Feature: Admin can monitor and manage posts
  View and remove list of posts
  
  Scenario: I want to see existing posts
    Given I am an admin
	When I view the Rides page
	Then I should see existing posts
  
  Scenario: I want to remove a post
    Given I am an admin
	And a ride exists
	And I view the Rides page
	When I click on the delete button
	Then the post should be deleted