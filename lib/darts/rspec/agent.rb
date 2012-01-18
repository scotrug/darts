require 'darts/coverage'
require 'darts/rspec/test_case'
require 'darts/source_file'

module Darts
  module RSpec
    class Agent
      def initialize(mappings)
        @mappings = mappings
      end

      def before_each(example)
        Coverage.start
      end

      def after_each(example)
        test_case = TestCase.new(example.location)
        @mappings.store_coverage(test_case, coverage_result)
      end

      def at_exit
        @mappings.save
      end

    private

      def coverage_result
        result = []
        Coverage.result.each do |file, line_counts|
          result << file
        end
        result
      end
    end
  end
end
