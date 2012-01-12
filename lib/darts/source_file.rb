require 'darts/mappings'

module Darts
  UnknownSourceFile = Class.new(StandardError)

  class SourceFile
    def initialize(path)
      @path = path
      @mappings = Darts.mappings
    end

    def tests
      @mappings.tests_for_source_file(self)
    end

    def ==(other)
      eql?(other)
    end

    def eql?(other)
      other.path == self.path
    end

    def hash
      [path].hash
    end

    def to_s
      "Source file: #{path}"
    end

    attr_reader :path

  end

end
