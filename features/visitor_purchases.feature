@selenium
Feature: Visitors can purchase the product

  Scenario: Visitor purchases the product
    Given I am on the home page
    When I click on the call to action
    And I sucessfully pay as "foo@bar.com"
    And I sleep for 4 seconds
    Then I should be on the order success page
    And an order should exist for "foo@bar.com"
    And stripe should have recorded a charge for the last order

  Scenario: Visitor's actions are tracked by KISSmetrics
    Given I am on the home page
    When I click on the call to action
    Then KISSmetrics should receive a viewed checkout event
    And I sucessfully pay as "foo@bar.com"
    And I sleep for 4 seconds
    Then KISSmetrics should receive an identify event for "foo@bar.com"
    And KISSmetrics should receive a purchased event
    And KISSmetrics should receive a billed event for 149 dollars
