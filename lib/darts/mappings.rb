require 'darts/rspec/test_case'

module Darts
  class Mappings
    KeyError = IndexError if RUBY_VERSION < "1.9"
    
    def initialize
      warn(caller[0])
    end

    def tests_for_source_file(source_file)
      state.fetch(source_file)
    rescue KeyError => error
      raise UnknownSourceFile, "No mapping exists for #{source_file}.\n#{self}", error.backtrace
    end

    def store_coverage_for_test_case(test_case, source_files)
      source_files.each do |source_file|
        state[source_file] ||= []
        state[source_file] << test_case
      end
    end

    def save
      Store.save(state)
    end
    
    def to_s
      result = ["Mappings from #{Store.data_file_path}:\n"]
      state.each do |source_file, test_cases|
        result << "#{source_file.path}"
        test_cases.each do |test_case|
          result << "  #{test_case}"
        end
        result << ''
      end
      result.join("\n")
    end

    private

    def state
      @state ||= Store.load
    end

    module Store
      def self.data_file_path
        @data_file_path ||= File.join(Dir.pwd, '.darts')
      end

      def self.load
        return {} unless File.exists?(data_file_path)
        File.open(data_file_path) do |io|
          Marshal.load(io)
        end
      end

      def self.save(state)
        File.open(data_file_path, 'w') do |io|
          Marshal.dump(state, io)
        end
      end
    end

  end

  def self.mappings
    @mappings ||= Mappings.new
  end
end
