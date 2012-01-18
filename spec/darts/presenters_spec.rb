require 'darts/presenters'

module Darts
  module Presenters
    describe TestsHittingSourceFile do

      before do
        SourceFile.stub(:new => source_file)
        mappings.stub(:tests_for_source_file).with(source_file).and_return(tests)
      end

      let(:source_file) { stub }
      let(:mappings) { stub }
      let(:test_case) { stub }
      let(:tests) { [test_case] }
      let(:ui) { stub }

      it "returns whatever tests the SourceFile says have hit it" do
        ui.should_receive(:say).with(test_case)
        TestsHittingSourceFile.new(:mappings => mappings, :source_file_path => stub).present_on(ui)
      end

    end
  end
end
