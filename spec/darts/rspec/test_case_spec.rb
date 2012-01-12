require 'darts/rspec/test_case'

module Darts
  module RSpec
    describe TestCase do
      subject { TestCase.new('/path/to/foo_spec.rb:32') }

      describe "#store_coverage" do
        it "delegates to the mappings" do
          mappings = stub
          Mappings.stub(:new => mappings)
          coverage = stub
          mappings.should_receive(:store_coverage_for_test_case).with(subject, coverage)
          subject.store_coverage(coverage)
        end
      end
    end
  end
end
