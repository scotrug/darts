Feature: Background
  In order to run tests faster
  As a feature editor
  I want to only run tests if code that is being tested has changed

  Background:
    Given a file named "features/passing_background.feature" with:
    """
    Feature: Fruits

      Scenario: Apples have pips
        Given I have 1 apple
        Then there should be 1 apple with pips

      Scenario: Pears have fuzzy skin
        Given I have a pear
        Then there should be 1 fuzzy pear

      Scenario: Sweet fruits
        Given I have 1 apple
        And I have 1 pear
        Then there should be 1 sweet apple
        And there should be 1 sweet pear
    """

  Scenario: All tests are run
    Given I run the test "features/passing_background.feature" with darts
    Then scenario "Apples have pips" should run
    And scenario "Pears have fuzzy skin" should run
    And scenario "Sweet fruits" should run
    And dependency should exist generated
    And class Apple effects following scenarios
      | Apples have pips |
      | Sweet fruits     |
    And class Pear effects following scenarios
      | Pears have fuzzy skin |
      | Sweet fruits          |

  Scenario: Only apple scenario get run because apple class was changed
    Given dependency file exists
    And class Apple was changed not to have pips
    When I run the test "features/passing_background.feature" with darts
    Then scenario "Apples have pips" should run
    And scenario "Sweet fruits" should run
    And scenario "Pears have fuzzy skin" should not run
    And dependency file should not be updated

  Scenario: Only pear scenario get run because pear class was changed
    Given dependency file exists
    And class Pear was changed to be smooth
    When I run the test "features/passing_background.feature" with darts
    And scenario "Sweet fruits" should run
    And scenario "Pears have fuzzy skin" should run
    Then scenario "Apples have pips" should not run
    And dependency file should not be updated

  Scenario: Both apple and pear scenarios should run because fruit was updated
    Given dependency file exists
    And class Fruit was changed not to be sweet
    When I run the test "features/passing_background.feature" with darts
    Then scenario "Apples have pips" should run
    And scenario "Sweet fruits" should run
    And scenario "Pears have fuzzy skin" should run
    And dependency file should not be updated

  Scenario: A scenario is updated that effects darts dependencies
    Given dependency file exists
    And "features/passing_background.feature" is updated with:
    """
    Feature: Fruits

      Scenario: Apples have pips
        Given I have 1 apple
        Then there should be 1 apple with pips

      Scenario: Pears have fuzzy skin
        Given I have a pear
        Then there should be 1 fuzzy pear

      Scenario: Sweet fruits
        Given I have 1 apple
        Then there should be 1 sweet apple
    """
    When I run the test "features/passing_background.feature" with darts
    Then scenario "Apples have pips" should run
    And scenario "Sweet fruits" should run
    And scenario "Pears have fuzzy skin" should run
    And dependency file should be updated
    And Apple should affect scenarios
    And class Apple effects following scenarios
      | Apples have pips |
      | Sweet fruits     |
    And class Pear effects following scenarios
      | Pears have fuzzy skin |