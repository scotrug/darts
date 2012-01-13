require 'darts/rspec/test_case'

module Darts
  module RSpec
    describe TestCase do
      subject { TestCase.new('/path/to/foo_spec.rb:32') }
      let(:mappings) { stub }
      before { Darts.stub(:mappings => mappings) }

      describe "#store_coverage" do
        let(:coverage) { stub }

        it "delegates to the mappings" do
          mappings.should_receive(:store_coverage_for_test_case).with(subject, coverage)
          subject.store_coverage(coverage)
        end
      end
    end
  end
end
