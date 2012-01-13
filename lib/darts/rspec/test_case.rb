require 'darts/mappings'

module Darts
  module RSpec
    class TestCase
      def initialize(location)
        full_path, @line = location.split(":")
        @path = full_path.gsub("#{Dir.pwd}/", '')
      end

      def to_s
        "#{@path}:#{@line}"
      end

      def store_coverage(coverage)
        Darts.mappings.store_coverage_for_test_case(self, coverage)
      end
    end
  end
end
