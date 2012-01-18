Feature: See specs for source file

  Scenario: Find a single spec

    Given two classes, each with corresponding RSpec specs:
      | lib/interesting.rb |
      | lib/stable.rb      |
    And Darts has watched the specs run twice
    When I ask Darts which specs touch "lib/interesting.rb"
    Then I should be given this list:
      | spec/interesting_spec.rb:5 |

  Scenario: Find multiple specs
    Given a module which is touched by two separate RSpec specs
    And Darts has watched the specs run
    When I ask Darts which specs touch the module
    Then I should be given a list with both specs
