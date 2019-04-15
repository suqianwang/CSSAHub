Feature: Handle Invalid Routes
  Invalid routes should redirect to the home page
  
  Scenario: Invalid route
    Given I am logged in
    When I visit an invalid route
	Then I should be redirected to the home page
	
  Scenario: Invalid route
    Given I am logged in
    When I visit an invalid route for accounts
	Then I should be redirected to the home page
	
  Scenario: Invalid route
    Given I am logged in
    When I visit an invalid route for rides
	Then I should be redirected to the home page