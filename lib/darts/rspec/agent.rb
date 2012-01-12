require 'darts/coverage'
require 'darts/rspec/test_case'
require 'darts/source_file'

module Darts
  module RSpec
    class Agent
      def before_each(example)
        Coverage.start
      end

      def after_each(example)
        test_case = TestCase.new(example.location)
        test_case.store_coverage(coverage_result)
      end

      def after_all
        Darts.mappings.save
      end

    private
      def coverage_result
        result = []
        Coverage.result.each do |file, line_counts|
          result << SourceFile.new(file)
        end
        result
      end
    end
  end
end
