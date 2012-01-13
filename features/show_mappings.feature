Feature: Show mappings

  Scenario:
    Given two classes, each with corresponding RSpec specs:
      | interesting.rb |
      | stable.rb      |
    And Darts has watched the specs run once
    When I ask Darts to show the mappings
    Then I should see:
      """
      lib/interesting.rb
        spec/interesting_spec.rb
      
      lib/stable.rb
        spec/stable_spec.rb
      """
