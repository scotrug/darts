require 'darts/rspec/test_case'

module Darts
  module RSpec
    describe TestCase do
      subject { TestCase.new(path) }
      let(:path) { '/path/to/foo_spec.rb:32' }
      let(:mappings) { stub }
      before { Darts.stub(:mappings => mappings) }

      describe "#eql?" do
        it "is true for another TestCase with the same path" do
          subject.should be_eql(stub(:path => subject.path))
        end
      end

      describe "#hash" do
        it "it is the same for two instances with the same path" do
          subject.hash.should == TestCase.new("#{subject.path}:1").hash
        end

        it "it is different for two instances with different paths" do
          other_file_path = File.expand_path('../somewhere_else_spec.rb')
          `touch #{other_file_path}`
          subject.hash.should_not == TestCase.new("#{other_file_path}:1").hash
        end
      end
    end
  end
end
