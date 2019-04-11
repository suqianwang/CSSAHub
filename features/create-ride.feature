Feature: Create Ride
  Create a ride with given specifications
    
  Scenario Outline: Create a ride request
    Given I am logged in
    And A matching ride exists
    And I am on the new ride page
    When I select my role as "<role>"
    And I fill in the form with a matching ride
    And I press Submit
    Then I should be on the auto-matching page
    When I press follow the link View all rides
    Then I should be on the rides page

    
  Examples:
    | role |
    | Driver |
    | Passenger |


  Scenario: Rides won't match if driver capacity is lower
    Given I am logged in
    And A passenger ride exists that is not a match because of capacity
    And I am on the new ride page
    When I select my role as "Driver"
    And I fill in the form
    And I press Submit
    Then I should be on the auto-matching page
    Then I should see no match


  Scenario: Rides won't match if passenger capacity is higher
    Given I am logged in
    And A driver ride exists that is not a match because of capacity
    And I am on the new ride page
    When I select my role as "Passenger"
    And I fill in the form
    And I press Submit
    Then I should be on the auto-matching page
    Then I should see no match
	
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