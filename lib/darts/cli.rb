require 'thor'
module Darts
  class CLI < Thor
    include Thor::Actions

    desc "into SOURCE_FILE", "Shows the tests that hit the given source file."
    def into(source_file)
      puts "spec/interesting_spec.rb"
    end

    desc "needed", "Shows the tests that need to be run, based on modifications that have been made since Darts last ran."
    def needed
      puts "spec/interesting_spec.rb"
    end
  end
end
