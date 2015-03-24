@default
Feature: Varnish log service
  In order to use varnishlog
  As a Developer
  I want varnishlog to be running

  Scenario: varnishlog
    Given Varnish is installed
    And Varnish is started
    When I run varnishlog
    Then I should see ping
