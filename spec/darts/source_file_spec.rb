require 'darts/source_file'

module Darts
  describe SourceFile do
    before do
      FileUtils.mkdir_p 'tmp/specs/lib'
      @original_pwd = Dir.pwd
      Dir.chdir 'tmp/specs'
    end
    
    after do
      Dir.chdir @original_pwd
    end

    let(:source_file_path) { File.join(Dir.pwd, 'lib/foo.rb') }
    let(:subject) do
      `touch #{source_file_path}`
      SourceFile.new(source_file_path)
    end
    
    describe ".new" do
      context "when the file doesn't exist" do
        it "raises an error" do
          expect { SourceFile.new('blah') }.to raise_error(Errno::ENOENT)
        end
      end
      
      context "when the file is a relative path" do
        it "copes" do
          SourceFile.new('lib/foo.rb').path.should == 'lib/foo.rb'
        end
      end
    end

    describe "#tests" do
      let(:mappings) { stub }

      before do
        Darts.stub(:mappings => mappings)
      end

      it "looks up the tests from the mappings" do
        tests = stub
        mappings.should_receive(:tests_for_source_file).with(subject).and_return(tests)
        subject.tests.should == tests
      end
    end

    describe "#path" do
      it "returns the path, relative to the current working directory" do
        subject.path.should == 'lib/foo.rb'
      end
    end
    
    describe "#outside_pwd?" do
      it "is true for a file outside the working directory" do
        other_file_path = File.expand_path('../somewhere_else.rb')
        `touch #{other_file_path}`
        SourceFile.new(other_file_path).should be_outside_pwd
      end
    end

    describe "#to_s" do
      it "returns a description of the object" do
        subject.to_s.should == 'lib/foo.rb'
      end
    end

    describe "#eql?" do
      it "is true for another SourecFile with the same path" do
        subject.should be_eql(stub(:path => subject.path))
      end
    end

    describe "#hash" do
      it "it is the same for two instances with the same path" do
        subject.hash.should == SourceFile.new(source_file_path).hash
      end

      it "it is different for two instances with different paths" do
        other_file_path = File.expand_path('../somewhere_else.rb')
        `touch #{other_file_path}`
        subject.hash.should_not == SourceFile.new(other_file_path).hash
      end
    end

  end
end
