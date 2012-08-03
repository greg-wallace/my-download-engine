Feature: Kissmetrics integration

  Scenario: Basic code shows up on pages
    When I am on the home page
    Then the page contains the KISSmetrics tracking code
    And KISSmetrics receives a viewed landing page event
