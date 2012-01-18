require 'rubygems' if RUBY_VERSION < "1.9"
require 'thor'
require 'darts/presenters'
require 'darts/mappings'

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

    desc "into SOURCE_FILE_PATH", "Shows the tests that hit the given source file."
    def into(source_file_path)
      present Presenters::TestsHittingSourceFile,
        :source_file_path => source_file_path,
        :mappings => Mappings.new
    end

    desc "mappings", "Shows the mappings that Darts has stored."
    def mappings
      present Presenters::Mappings,
        :mappings => Mappings.new
    end

    private

    def present(presenter, options)
      presenter.new(options).present_on(self)
    end

  end

end
