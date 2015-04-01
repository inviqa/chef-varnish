Feature: Varnish Nagios plugin
  In order to ensure that my system is performing well
  As a systems administrator
  I want the ability to monitor Varnish

  Scenario: Nagios plugin
    Given the Nagios plugin is installed
    When I request the plugin help
    Then I see that the help is shown

