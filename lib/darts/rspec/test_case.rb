require 'darts/mappings'

module Darts
  module RSpec
    class TestCase
      def initialize(location)
        @location = location
      end

      def to_s
        @location
      end

      def store_coverage(coverage)
        Mappings.new.store_coverage_for_test_case(self, coverage)
      end
    end
  end
end
