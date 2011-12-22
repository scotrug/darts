Feature: Run selective RSpec examples

  Scenario:
    Given two classes, each with corresponding RSpec specs:
      | wow.rb    |
      | stable.rb |
    And Darts has watched the specs run once
    When I modify "wow.rb"
    And I ask Darts which specs I should run
    Then I should be told to just run the specs for "wow.rb"

