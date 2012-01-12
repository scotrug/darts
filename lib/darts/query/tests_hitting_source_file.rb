require 'darts/source_file'

module Darts
  module Query

    class TestsHittingSourceFile
      def initialize(source_file_path, &block)
        @source_file = Darts::SourceFile.new(source_file_path)
        tests.each(&block) if block
      end

      def tests
        @source_file.tests
      end
    end

  end
end
