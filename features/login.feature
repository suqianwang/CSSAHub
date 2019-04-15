Feature: Login
  Access an account given correct credentials
  
  Scenario: Regular login
    Given I am registered
    And I am on the home page
    When I follow the sign in link
    And I sign in
    Then I should be redirected to the services page
    
  Scenario: Re-login
    Given I am logged in
    When I visit the login page
    Then I should be redirected to the services page
    
  Scenario: Create an account
    Given I am not registered
    And I am on the home page
    When I follow the sign in link
    And I sign in
    Then my account should be created
    And I should be redirected to the services page
    
  Scenario: Login to archived account
    Given I am registered
    And my account is archived
    And I am on the home page
    When I follow the sign in link
    And I sign in
    Then I should be redirected to the home page
    And I should see a message saying my account is disabled
    
  Scenario: Admin login
    Given I am registered as an admin
    And I am on the home page
    When I follow the sign in link
    And I sign in
    Then I should be redirected to the admin page
  
  Scenario: Logout
    Given I am logged in
    When I open the navbar dropdown
    And I click logout
    Then I should be redirected to the home page
    
  # Scenario: Invalid login credentials
  #   Given I am on the home page
  #   When I follow the sign in link
  #   And I sign in with invalid credentials
  #   Then I should be redirected to the home page
    
  # Scenario: Login with non-TAMU email
  #   Given I am on the home page
  #   When I follow the sign in link
  #   And I sign in with a non-TAMU email
  #   Then I should be redirected to the home page
  #   And I should see a message saying to use a TAMU email
    