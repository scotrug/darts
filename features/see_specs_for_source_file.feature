Feature: See specs for source file

  Scenario:
    Note that this doesn't have a high fidelity yet: it just shows which file you need to run, rather than the actual examples within it.

    Given two classes, each with corresponding RSpec specs:
      | interesting.rb |
      | stable.rb      |
    And Darts has watched the specs run once
    When I ask Darts which specs touch "interesting.rb"
    Then I should be given this list:
      | spec/interesting_spec.rb |
