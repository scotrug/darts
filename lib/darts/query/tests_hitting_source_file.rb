module Darts
  module Query
    class TestsHittingSourceFile
      def initialize(source_file)
        @source_file = source_file
        yield tests
      end
      
      def tests
        []
      end
    end
  end
end