module Darts
  module Query
    class TestsThatNeedRunning
      def initialize
        yield tests
      end
      
      def tests
        []
      end
    end
  end
end