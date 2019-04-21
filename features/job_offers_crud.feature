Feature: Job Offers CRUD
  In order to get employees
  As a job offerer
  I want to manage my offers

  Background:
  	Given I am logged in as job offerer
@wip
  Scenario: Create new offer
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
		And confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy" in My Offers
    And I should see that the Required Experience is "Not specified"

  Scenario: Update offer
    Given I have "Programmer vacancy" offer in My Offers
    And I edit it
    And I set title to "Programmer vacancy!!!"
    And I save the modification
    Then I should see "Offer updated"
    And I should see "Programmer vacancy!!!" in My Offers

  Scenario: Delete offer
    Given I have "Programmer vacancy" offer in My Offers
    Given I delete it
    Then I should see "Offer deleted"
    And I should not see "Programmer vacancy!!!" in My Offers

@wip
  Scenario: Create new offer with required experience
    Given I access the new offer page
    When I fill the title with "Programmer vacancy with experience"
    And I set the required experience to "5"
		And confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy with experience" in My Offers
    And I should see that the Required Experience is 5
@wip
  Scenario: Increase offer required experience
    Given I have "Programmer vacancy with experience" offer in My Offers
    And I edit it
    And I set the required experience to "6"
    And I save the modification
    Then I should see "Offer updated"
    And I should see that the Required Experience is 6
@wip
  Scenario: Remove offer required experience
    Given I have "Programmer vacancy with experience" offer in My Offers
    And I edit it
    And I set the required experience to "0"
    And I save the modification
    Then I should see "Offer updated"
    And I should see that the Required Experience is "Not specified"