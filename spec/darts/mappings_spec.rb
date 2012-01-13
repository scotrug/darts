require 'darts/mappings'
require 'darts/source_file'

module Darts
  describe Mappings do
    let(:store) { Mappings::Store }

    describe "#tests_for_source_file" do

      let(:state) do
        { SourceFile.new('foo.rb') => [ RSpec::TestCase.new('foo_spec.rb:32') ] }
      end

      it "returns an Array of TestCases" do
        store.stub(:load => state)
        tests = subject.tests_for_source_file(SourceFile.new('foo.rb'))
        tests.should be_kind_of(Array)
        tests.first.should be_kind_of(RSpec::TestCase)
      end

      it "raises an error when the source file is unknown" do
        expect { subject.tests_for_source_file(stub) }.to raise_error(UnknownSourceFile)
      end

    end

    describe "#store_coverage_for_test_case" do
      it "updates the state" do
        state = {}
        store.stub(:load => state)
        coverage = [ SourceFile.new('foo.rb') ]
        test_case = stub
        subject.store_coverage_for_test_case(test_case, coverage)
        state.should == {
          SourceFile.new('foo.rb') => [ test_case ]
        }
      end
    end

    describe "#save" do
      it "delegates to the State" do
        state = stub
        store.stub(:load => state)
        store.should_receive(:save).with(state)
        Mappings.new.save
      end
    end
    
    describe "#to_s" do
      it "shows the path where the mappings are stored" do
        store.stub(:data_file_path).and_return 'path/to/.darts'
        Mappings.new.to_s.should =~ /path\/to\/\.darts/
      end
      
      it "shows each of the source files" do
        state = { 'foo' => ['foo_spec', 'bar_spec'] }
        store.stub(:load => state)
        Mappings.new.to_s.should =~ /foo/
      end
    end

    describe Mappings::Store do
      it "can round-trip a ruby Hash" do
        hash = { 'foo' => [ :bar ] }
        store.save(hash)
        store.load.should == hash
      end
    end
  end
end
