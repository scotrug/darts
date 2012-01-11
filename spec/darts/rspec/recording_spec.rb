require 'darts/rspec/recording'

module Darts
  module RSpec

    describe Recording do
      describe "#test_location" do
        it "returns a path relative to the current working directory" do
          Dir.stub(:pwd => '/foo/bar')
          example = stub(:location => '/foo/bar/baz:32')
          Recording.new(example).test_location.should == 'baz:32'
        end
      end
      
      describe "#source_files" do
        it "returns a hash whose keys are the files that were touched during the recording" do
          recording = Recording.new(stub.as_null_object)
          load File.dirname(__FILE__) + '/foo.rb'
          recording.source_files.keys.should == ['spec/darts/rspec/foo.rb']
        end
        
        it "returns a hash where the values indicate whether a line was touched" do
          recording = Recording.new(stub.as_null_object)
          load File.dirname(__FILE__) + '/foo.rb'
          Foo.new.call
          recording.source_files.should == { 'spec/darts/rspec/foo.rb' => [1,1,1,nil,nil] }
        end
      end

    end
    
  end
end
