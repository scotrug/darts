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
        mappings.tests_for_source_file(source_file).each do |test|
          ui.say test
        end
      end

      private

      def source_file
        @source_file = SourceFile.new(option(:source_file_path))
      end
    end

    class Mappings < Base
      def present_on(ui)
        mappings.print { |line| ui.say(line) }
      end
    end

  end
end
