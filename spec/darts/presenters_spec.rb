require 'darts/presenters'

module Darts
  module Presenters
    describe TestsHittingSourceFile do

      before do
        SourceFile.stub(:new => source_file)
        mappings.stub(:tests_for_source_files => [ test_case ])
      end

      let(:source_file) { stub }
      let(:mappings) { stub }
      let(:test_case) { stub }
      let(:ui) { stub.as_null_object }
      let(:paths) { '/path/to/file.rb' }

      subject { TestsHittingSourceFile.new(:mappings => mappings, :source_file_paths => paths) }

      it "returns whatever tests the mappings says have hit the source file" do
        ui.should_receive(:say).with(test_case)
        subject.present_on(ui)
      end

      context "with multiple source files" do
        let(:paths) { 'file1,file2' }

        it "looks up each source_file" do
          SourceFile.should_receive(:new).with('file1')
          SourceFile.should_receive(:new).with('file2')
          subject.present_on(ui)
        end
      end

    end
  end
end
