require 'darts/query/tests_hitting_source_file.rb'

module Darts
  module Query
    describe TestsHittingSourceFile do

      it "finds a SourceFile" do
        source_file_name = '/foo/bar'
        SourceFile.should_receive(:new).with(source_file_name)
        TestsHittingSourceFile.new(source_file_name)
      end

      before do
        SourceFile.stub(:new => source_file)
        Darts.stub(:mappings => mappings)
        mappings.stub(:tests_for_source_file).with(source_file).and_return(tests)
      end

      let(:source_file) { stub }
      let(:mappings) { stub }
      let(:tests) { stub }

      it "returns whatever tests the SourceFile says have hit it" do
        TestsHittingSourceFile.new(source_file).tests.should == tests
      end

    end
  end
end
