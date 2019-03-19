Feature: Admin can monitor and manage posts
  View and remove list of posts
  
  Scenario: I want to see existing posts
    Given I am an admin
	When I view the Posts page
	Then I should see existing posts
  
  Scenario: I want to remove a post
    Given I am an admin
	And I view the Posts page
	When I click on the remove post button
	Then the post should be deleted

  Scenario: I am a non-admin accessing the Posts page
    Given I am not an admin
	When I view the Posts page
	Then I I will be redirected to the main hub
