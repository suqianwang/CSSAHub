Feature: Profile
  View personal information related to me
  
  Scenario: I want to see my info
    Given I am logged in
	When I am on the profile page
	Then I should see my information
	
  Scenario: I should not see profile
    Given I am an admin
    When I am on the profile page
    Then I should be redirected to the admin page	