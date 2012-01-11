Feature: Run selective RSpec examples

  Scenario:
    Given two classes, each with corresponding RSpec specs:
      | interesting.rb |
      | stable.rb      |
    And Darts has watched the specs run once
    When I modify "lib/interesting.rb"
    And I ask Darts which specs I should run
    Then I should be given this list:
      | spec/interesting_spec.rb |

