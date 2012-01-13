require 'darts/mappings'
require 'darts/source_file'

module Darts
  describe Mappings do
    let(:store) { Mappings::Store }
    let(:state) { {} }
    before { store.stub(:load => state) }

    describe "#tests_for_source_file" do
      let(:source_file_a) { stub }
      let(:test_case_x) { stub }
      let(:state) do
        { source_file_a => [ test_case_x ] }
      end

      it "returns an Array of TestCases" do
        tests = subject.tests_for_source_file(source_file_a)
        tests.should be_kind_of(Array)
        tests.first.should == test_case_x
      end

      it "raises an error when the source file is unknown" do
        expect { subject.tests_for_source_file(stub) }.to raise_error(UnknownSourceFile)
      end

    end

    describe "#store_coverage_for_test_case" do
      let(:source_file_path) { 'path/to/source_file.rb' }
      let(:test_case) { stub }
      let(:coverage) { [ source_file_path ] }
      
      it "maps the path into a SourceFile object" do
        SourceFile.should_receive(:new).with(source_file_path)
        subject.store_coverage_for_test_case(test_case, coverage)
      end
      
      let(:source_file) { stub(:outside_pwd? => false) }
      before { SourceFile.stub(:new => source_file) }
      
      it "updates the state" do
        subject.store_coverage_for_test_case(test_case, coverage)
        state.should == {
          source_file => [ test_case ]
        }
      end
      
      it "ignores files outside the working directory" do
        source_file.stub(:outside_pwd? => true)
        subject.store_coverage_for_test_case(stub, coverage)
        state.should == {}
      end
    end

    describe "#save" do
      it "delegates to the State" do
        store.should_receive(:save).with(state)
        Mappings.new.save
      end
    end
    
    describe "#print" do
      let(:state) do
        { 'foo.rb' => ['foo_spec', 'bar_spec'] }
      end

      it "shows the path where the mappings are stored" do
        store.stub(:data_file_path).and_return 'path/to/.darts'
        Mappings.new.to_s.should =~ /path\/to\/\.darts/
      end
      
      it "shows each of the source files" do
        Mappings.new.to_s.should =~ /foo/
      end
    end

    describe Mappings::Store do
      before { store.unstub(:load) }
      it "can round-trip a ruby Hash" do
        hash = { 'foo' => [ :bar ] }
        store.save(hash)
        store.load.should == hash
      end
    end
  end
end
