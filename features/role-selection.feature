Feature: Select role
  Select whether I'm creating or offering a ride
  
  Scenario Outline: I'm creating or offering a ride
    Given I want to be a "<role>"
    When I select my role
    Then a ride should be created with me as "<role>"
    
  Examples:
    | role |
    | driver |
    | passenger |