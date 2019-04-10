Feature: Show rides
  Show my rides in the profile
  
  Scenario: I want to look at my rides
    Given I am logged in
    And a ride exists
	When I am on the profile page
    And I click on the match link
    Then the ride should be shown