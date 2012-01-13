require 'darts/rspec/agent'

module Darts
  module RSpec
    describe Agent do
      let(:example) { stub(:location => '/bar/bar/baz_spec:39') }

      describe "#before_each" do
        it "starts recording code coverage" do
          Coverage.should_receive :start
          subject.before_each example
        end
      end

      describe "#after_each" do
        let(:source_file) { stub(:path => '/path/to/foo.rb') }
        let(:raw_coverage_result) do
          { source_file.path => [1, 1, nil] }
        end
        before do
          Coverage.stub(:result => raw_coverage_result)
        end

        it "creates a TestCase and stores the coverage" do
          test_case = stub(TestCase)
          TestCase.stub(:new).
            with(example.location).
            and_return(test_case)
          test_case.should_receive(:store_coverage).with([source_file.path])
          subject.after_each example
        end
      end

      describe "#after_all" do
        it "tells the mappings to save" do
          Darts.mappings.should_receive(:save)
          subject.after_all
        end
      end

    end
  end
end
