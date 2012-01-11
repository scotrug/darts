require 'active_support/core_ext/string/inflections'

module Dsl

  def darts(task, *args)
    run_simple "../../bin/darts #{task} #{args.join(' ')}"
  end

  def run_specs_with_darts
    write_file('spec/spec_helper.rb', <<-BODY)
$: << File.expand_path(File.dirname(__FILE__) + '/../../../lib')
require 'darts/rspec'
BODY
    in_current_dir { `rspec` }
  end

  def output_from_darts
    all_stdout
  end

  def touch(filename)
    append_to_file(filename, "\n# a comment")
  end

private

  def write_class_with_spec(filename)
    write_file "lib/#{filename}", class_content(filename)
    spec_filename = spec_name_for(filename)
    write_file "spec/#{spec_filename}", spec_content(filename)
  end

  def class_content(filename)
    %{
class #{class_name_for(filename)}
  def call
    "#{filename} was called"
  end
end
}
  end

  def class_name_for(filename)
    filename.gsub('.rb', '').classify
  end

  def spec_content(filename)
    %{
require 'spec_helper'
require '#{filename}'

describe #{class_name_for(filename)} do
  it "can be called" do
    subject.call.should == "#{filename} was called"
  end
end
}
  end

  def spec_name_for(filename)
    filename.gsub('.rb', '_spec.rb')
  end
end

World(Dsl)
