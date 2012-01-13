require 'darts/rspec/test_case'

module Darts
  class Mappings
    KeyError = IndexError if RUBY_VERSION < "1.9"

    def tests_for_source_file(source_file)
      state.fetch(source_file)
    rescue KeyError => error
      raise UnknownSourceFile, "No mapping exists for #{source_file}. Mappings are: #{state.inspect}", error.backtrace
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

    private

    def state
      @state ||= Store.load
    end

    module Store
      DATA_FILE = File.join(Dir.pwd, '.darts')

      def self.load
        return {} unless File.exists?(DATA_FILE)
        File.open(DATA_FILE) do |io|
          Marshal.load(io)
        end
      end

      def self.save(state)
        File.open(DATA_FILE, 'w') do |io|
          Marshal.dump(state, io)
        end
      end
    end

  end

  def self.mappings
    @mappings ||= Mappings.new
  end
end
