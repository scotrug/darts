require 'darts/mappings'
require 'pathname'

module Darts
  UnknownSourceFile = Class.new(StandardError)

  class SourceFile
    def initialize(path)
      @path = Pathname.new(path).realpath
    end

    def outside_pwd?
      path =~ /^\.\./
    end

    def ==(other)
      eql?(other)
    end

    def eql?(other)
      other.path.to_s == path
    end

    def hash
      [path].hash
    end

    def to_s
      path
    end

    def path
      @path.relative_path_from(Pathname.new(Dir.pwd)).to_s
    end

  end

end
