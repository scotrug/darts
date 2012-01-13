if RUBY_VERSION >= "1.9"
  require 'coverage'

  module Darts
    Coverage = ::Coverage # until we need to support 1.8
  end
else
  require 'rcov'

  module Darts
    module Coverage
      def self.start
        
      end

      def self.result
        {}
      end
    end
  end
end

Darts::Coverage.start
