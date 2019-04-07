Feature: Create Ride
  Create a ride with given specifications
    
  Scenario Outline: Create a ride request
    Given I am logged in
    And I am on the new ride page
    When I select my role as "<role>"
    And I fill in the form
    And I press Submit
    Then I should be on the rides home page
    And I should see the newly created ride
    
  Examples:
    | role |
    | Driver |
    | Passenger |
	
  Scenario: Admin can not create a ride
    Given I am an admin
    And I am on the new ride page
    Then I should be redirected to the admin page
  
  Scenario: Create a ride request with errors
    Given I am logged in
    And I am on the new ride page
    When I fill in the form wrongly
    And I press Submit
    Then I should see errors for each wrong field