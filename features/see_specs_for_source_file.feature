Feature: See specs for source file

  Scenario: Find a single spec

    Given two classes, each with corresponding RSpec specs:
      | interesting.rb |
      | stable.rb      |
    And Darts has watched the specs run twice
    When I ask Darts which specs touch "lib/interesting.rb"
    Then I should be given this list:
      | spec/interesting_spec.rb:5 |
