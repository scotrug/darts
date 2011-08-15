require 'rcov'
require 'yaml'

analyzer = Rcov::CodeCoverageAnalyzer.new
results = {}
RSpec.configure do |config|
  config.before do
    analyzer.install_hook
  end
  config.after do
    files = analyzer.analyzed_files
    results[example.location] = files.reject { |f| f.match /\/gem/ }
    analyzer.remove_hook
  end
  config.after(:all) do
    puts results.to_yaml
  end
end
