Feature: Navigate between Admin option pages
  View and navigate to all admin option pages

  Scenario: I want to see what options I can manage
    Given I am not an admin
    When I visit admin page
    Then I will be redirected to the main hub
  
  Scenario Outline: I want to see what options I can manage
    Given I am an admin
    Given "<option>" exists on the admin page
    When I view the admin page
    Then I should see "<option>" on the admin page
    
  Examples:
    | option |
    | Active Accounts |
	| Archived Accounts |
	| Posts |
	
  Scenario Outline: I'm selecting an option to manage
    Given I am an admin
    Given I want to go to the "<option>" page from the admin page
    When I select the "<option>" on the admin page
    Then the site should navigate to the "<corresponding>" page from the admin page
		
  Examples:
    | option | corresponding |
    | Active Accounts | Accounts |
	| Archived Accounts | Archived |
	| Posts | Rides |
