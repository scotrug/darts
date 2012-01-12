require 'darts/source_file'

module Darts
  describe SourceFile do
    describe "#tests" do
      let(:source_file) { SourceFile.new('') }
      let(:mappings) { stub }

      before do
        Darts.stub(:mappings => mappings)
      end

      it "looks up the tests from the mappings" do
        tests = stub
        mappings.should_receive(:tests_for_source_file).with(source_file).and_return(tests)
        source_file.tests.should == tests
      end
    end

    describe "#path" do
      it "returns the path" do
        SourceFile.new('foo.rb').path.should == 'foo.rb'
      end
    end

    describe "#to_s" do
      it "returns a description of the object" do
        SourceFile.new('foo.rb').to_s.should == 'Source file: foo.rb'
      end
    end

    describe "#eql?" do
      it "is true for another SourecFile with the same path" do
        SourceFile.new('foo.rb').should be_eql(stub(:path => 'foo.rb'))
      end
    end

    describe "#hash" do
      it "it is the same for two instances with the same path" do
        SourceFile.new('foo.rb').hash.should == SourceFile.new('foo.rb').hash
      end

      it "it is different for two instances with different paths" do
        SourceFile.new('foo.rb').hash.should_not == SourceFile.new('bar.rb').hash
      end
    end

  end
end
