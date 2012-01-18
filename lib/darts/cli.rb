require 'rubygems' if RUBY_VERSION < "1.9"
require 'thor'
require 'darts/query/tests_hitting_source_file'

module Darts
  class CLI < Thor
    include Thor::Actions
    extend Thor::Actions

    def self.help(shell, *args)
      shell.print_wrapped <<-MESSAGE
darts - Dependency-aware ruby testing
MESSAGE
      shell.say
      super
    end

    desc "into SOURCE_FILE", "Shows the tests that hit the given source file."
    def into(source_file)
      Query::TestsHittingSourceFile.new(source_file) do |test|
        say test
      end
    end

    desc "mappings", "Shows the mappings that Darts has stored."
    def mappings
      Darts.mappings.print { |line| say(line) }
    end

  end
end
