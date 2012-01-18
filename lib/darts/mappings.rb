require 'darts/rspec/test_case'

module Darts

  class Mappings

    def tests_for_source_files(source_files_to_find)
      recordings = state.select do |test_case, source_files|
        (source_files & source_files_to_find).any?
      end
      if recordings.empty?
        raise UnknownSourceFile, "No mappings exist for any of '#{source_files_to_find}'.\n#{self}"
      end
      recordings.map { |test_case, source_files| test_case }
    end

    def store_coverage(test_case, source_file_paths)
      source_files = source_file_paths.map { |path| SourceFile.new(path) }
      source_files.reject! { |source_file| source_file.outside_pwd? }
      source_files.reject! { |source_file| source_file.path == test_case.path }
      state[test_case] = source_files
    end

    def save
      Store.save(state)
    end

    def print
      yield "Mappings from #{Store.data_file_path}:"
      state.each do |source_file, test_cases|
        yield "#{source_file}"
        test_cases.each do |test_case|
          yield "  #{test_case}"
        end
      end
    end

    def to_s
      lines = []
      print { |line| lines << line }
      lines.join("\n")
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

end
