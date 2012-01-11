require 'darts'

module Darts
  module RSpec

    class Recording
      attr_reader :test_location

      def initialize(example)
        @test_location = clean(example.location)
        Coverage.start
      end

      def test_type
        :rspec
      end

      def source_files
        return @source_files if @source_files
        @source_files = {}
        Coverage.result.each do |file, lines|
          @source_files[clean(file)] = lines
        end
        @source_files
      end
      
      private
      
      def clean(path)
        path.gsub("#{Dir.pwd}/", '')
      end
    end

  end
end
