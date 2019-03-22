Feature: Create Ride
  Create a ride with given specifications
  
  Scenario Outline: Create a ride request
    Given I am logged in
    And I am on the new ride page
    When I select my role as "<role>"
    Then the passenger form should appear
    When I fill in the form
    And I press Submit
    Then I should be on the ride's page
    And I should see the details of my newly created ride
    
  Examples:
    | role |
    | driver |
    | passenger |