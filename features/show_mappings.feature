Feature: Show mappings

  Scenario: Two source files, each with a spec
    Given two classes, each with corresponding RSpec specs:
      | interesting.rb |
      | stable.rb      |
    And Darts has watched the specs run once
    When I ask Darts to show the mappings
    Then I should see:
      """
      spec/interesting_spec.rb:5
        lib/interesting.rb
      spec/stable_spec.rb:5
        lib/stable.rb
      """

