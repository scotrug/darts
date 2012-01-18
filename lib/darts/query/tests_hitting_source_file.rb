require 'darts/source_file'

module Darts
  module Query

    class TestsHittingSourceFile

      def initialize(source_file_path, &block)
        @source_file = Darts::SourceFile.new(source_file_path)
        tests.each(&block) if block
      end

      def tests
        Darts.mappings.tests_for_source_file(@source_file)
      end
    end

  end
end
