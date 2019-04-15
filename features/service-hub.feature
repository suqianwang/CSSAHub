Feature: Navigate services
  View and navigate to all services available to me
  
  Scenario Outline: I want to see all services
    Given I am logged in
    When I view the hub page
    Then I should see "<service>"
    
  Examples:
    | service |
    | Transportation |
  
  Scenario Outline: I'm selecting a service
    Given I am logged in
    And I want to go to the "<service>" page
    When I select the service
    Then I should be redirected to the "<corresponding>" page
    
  Examples:
    | service | corresponding |
    | Transportation Service| rides |

	
  Scenario: Admin should not see hub
   Given I am an admin
   When I view the hub page
   Then I should be redirected to the admin page