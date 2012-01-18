require 'darts/source_file'

module Darts
  module Presenters

    class Base
      def initialize(options)
        @options = options
      end

      private

      def mappings
        @mappings ||= option(:mappings)
      end

      def option(name)
        options[name] || raise(ArgumentError, "#{name} is required by #{self}")
      end

      attr_reader :options
    end

    class TestsHittingSourceFile < Base
      def present_on(ui)
        tests = mappings.tests_for_source_files(source_files)
        ui.say tests.join(" ")
      end

      private

      def source_files
        @source_files = source_file_paths.map { |path| SourceFile.new(path) }
      end

      def source_file_paths
        option(:source_file_paths).split(',')
      end
    end

    class Mappings < Base
      def present_on(ui)
        mappings.print { |line| ui.say(line) }
      end
    end

  end
end
