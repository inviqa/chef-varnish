@default
Feature: Varnish service
  In order to use Varnish HTTP Accelerator
  As a Developer
  I want the service to be started

  Scenario: varnishd
    Given Varnish is installed
    And Varnish is started
    When the service status is requested
    Then it should be running

