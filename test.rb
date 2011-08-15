$:<< File.expand_path(File.dirname(__FILE__) + '/lib')


require 'rubygems'
require 'rcov'
require 'foo' # you have to require the file after rcov for rcov to see what happens inside it.
require 'yaml'

analyzer = Rcov::CodeCoverageAnalyzer.new
results = {}

analyzer.install_hook

foo
bar

files = analyzer.analyzed_files
p files
analyzer.remove_hook
coverage = {}
files.reject { |f| f.match /\/gem/ }.map do |file|
  coverage[file] = analyzer.data(file)
end
results['test.rb'] = coverage

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

