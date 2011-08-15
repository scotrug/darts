$:<< File.expand_path(File.dirname(__FILE__) + '/../../lib')
  require 'apple'

Given /^apples have pips$/ do
  Apple.new.should have_pips
end

Given /^fruit are generally sweet$/ do
end

Given /^pears have furry skin$/ do
end


require 'rcov'
require 'yaml'

analyzer = Rcov::CodeCoverageAnalyzer.new
results = {}

Before do
  analyzer.install_hook
end

After do |scenario|
  files = analyzer.analyzed_files
  analyzer.remove_hook
  coverage = {}
  files.reject { |f| f.match /\/gem/ }.map do |file|
    coverage[file] = analyzer.data(file)
  end
  results[scenario.file_colon_line] = coverage
end

at_exit do
  require 'term/ansicolor'
  include Term::ANSIColor

  puts
  puts red, "Darts", reset
  puts

  results.each do |scenario, files|
    puts
    puts
    puts scenario

    files.each do |file, data|
      puts
      puts file
      lines, covered, counts = *data
      lines.each_with_index do |line, index|
        is_covered = covered[index]
        count = counts[index]
        print blue('%05d' % count),
          ' ',
          (is_covered ? on_green : on_red),
          line.chomp,
          reset,
          "\n"
      end
    end
  end
end

