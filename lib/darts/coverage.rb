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
