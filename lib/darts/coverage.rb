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
        @analyzer = Rcov::CodeCoverageAnalyzer.new
        @analyzer.install_hook
      end

      def self.result
        @analyzer.remove_hook
        result = {}
        @analyzer.analyzed_files.each do |file|
          result[file] = []
        end
        result
      end
    end
  end
end

Darts::Coverage.start
