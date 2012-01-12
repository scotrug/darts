require 'darts/query/tests_hitting_source_file.rb'

module Darts
  module Query
    describe TestsHittingSourceFile do

      it "finds a SourceFile" do
        source_file_name = '/foo/bar'
        SourceFile.should_receive(:new).with(source_file_name)
        TestsHittingSourceFile.new(source_file_name)
      end

      it "returns whatever tests the SourceFile says have hit it" do
        tests = ['one_spec.rb', 'another_spec.rb']
        source_file = stub(:tests => tests)
        SourceFile.stub(:new => source_file)

        results = []
        TestsHittingSourceFile.new('whatever') { |test| results << test }
        results.should == tests
      end

      context "when the source file can't be found" do
        before do
          SourceFile.stub(:new).and_raise(UnknownSourceFile)
        end

        it "raises the error up" do
          expect { TestsHittingSourceFile.new('wrong') }.to raise_error(UnknownSourceFile)
        end

      end
    end
  end
end
