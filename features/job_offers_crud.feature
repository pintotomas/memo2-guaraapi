Feature: Job Offers CRUD
  In order to get employees
  As a job offerer
  I want to manage my offers

  Background:
  	Given I am logged in as job offerer

  Scenario: Create new offer
    Given I access the new offer page
    And I fill the title with "Programmer vacancy"
		When confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy" in My Offers
    And I should see that the Required Experience is "Not specified"

  Scenario: Update offer
    Given I have "Programmer vacancy" offer in My Offers
    And I edit it
    And I set title to "Programmer vacancy!!!"
    When I save the modification
    Then I should see "Offer updated"
    And I should see "Programmer vacancy!!!" in My Offers

  Scenario: Delete offer
    Given I have "Programmer vacancy" offer in My Offers
    Given I delete it
    Then I should see "Offer deleted"
    And I should not see "Programmer vacancy!!!" in My Offers


  Scenario: Create new offer with required experience
    Given I access the new offer page
    And I set the required experience to "5"
    And I fill the title with "Programmer vacancy with experience"    
		When confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy with experience" in My Offers
    And I should see that the Required Experience is "5"

  Scenario: Increase offer required experience
    Given I have "Programmer vacancy with experience" offer in My Offers
    And I edit it
    And I set the required experience to "6"
    When I save the modification
    Then I should see "Offer updated"
    And I should see that the Required Experience is "6"

  Scenario: Remove offer required experience
    Given I have "Programmer vacancy with experience" offer in My Offers
    And I edit it
    And I set the required experience to "0"
    When I save the modification
    Then I should see "Offer updated"
    And I should see that the Required Experience is "Not specified"