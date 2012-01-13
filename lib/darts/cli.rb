require 'rubygems' if RUBY_VERSION < "1.9"
require 'thor'
require 'darts/query/tests_hitting_source_file'
require 'darts/query/tests_that_need_running'

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

    desc "needed", "Shows the tests that need to be run, based on modifications that have been made since Darts last ran."
    def needed
      Query::TestsThatNeedRunning.new do |test|
        say test
      end
    end
  end
end
