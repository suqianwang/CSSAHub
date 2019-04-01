Feature: Profile
  View personal information related to me
  
  Scenario: I want to see my info
    Given I am logged in
	When I am on the profile page
	Then I should see my information