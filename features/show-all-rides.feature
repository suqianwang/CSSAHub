Feature: show all rides
  List all rides and their information

#  Background: rides in database
#    Given rides below
#
#    | role      |departure                                                          |destination                                          |start_date|start_time|end_time|seats|
#    | Driver    |Zachry Engineering Center, Spence Street, College Station, TX, USA |Sharetea, University Drive, College Station, TX, USA |05/10/2019|09:00     |11:00   |2    |
#    | Passenger |Zachry Engineering Center, Spence Street, College Station, TX, USA |Sharetea, University Drive, College Station, TX, USA |05/10/2019|10:00     |11:00   |1    |

  Scenario: I want to look at all the offered/requested rides
    Given I am logged in
    And I am on the rides page
    When I check the driver checkbox
    And I click Refresh
    Then only offered rides will show
    When I check the passenger checkbox
    And I uncheck the driver checkbox
    And I click Refresh
    Then only requested rides will show


  Scenario Outline: Contact my rides
    Given I am logged in
    And I am on the new ride page
    When I select my role as "<role>"
    And I fill in the form
    And I press Submit
    Then I should be on the auto-matching page
    When I press follow the link View all rides
    Then I should be on the rides page
    When I click contact "<role>"
    Then the "<role>" information will pop up


    Examples:
      | role |
      | Driver |
      | Passenger |

