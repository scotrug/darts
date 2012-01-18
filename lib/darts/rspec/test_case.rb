require 'darts/mappings'

module Darts
  module RSpec
    class TestCase
      attr_reader :path

      def initialize(location)
        full_path, @line = location.split(":")
        @path = full_path.gsub("#{Dir.pwd}/", '')
      end

      def to_s
        "#{@path}:#{@line}"
      end

      def eql?(other)
        @path == other.path
      end

      def hash
        [@path].hash
      end
    end
  end
end
