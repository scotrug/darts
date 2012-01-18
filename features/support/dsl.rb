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
    run_simple('rspec')
    @processes = nil # this tells aruba to clean the slate for another command
  end

  def output_from_darts
    all_stdout
  end

  def touch(filename)
    append_to_file(filename, "\n# a comment")
  end

  def write_class_with_spec(options = {})
    filename = options[:filename] || generate_class_filename
    write_file filename, class_content(filename, options)
    spec_filename = spec_name_for(filename)
    write_file spec_filename, spec_content(filename)
    spec_locations << "#{spec_filename}:5"
  end

  def write_module(options = {})
    filename = options[:filename] || generate_module_filename
    write_file filename, module_content(filename, options)
    filename
  end

  def spec_locations
    @spec_locations ||= []
  end

  def class_content(filename, options)
    if module_filename = options[:include_module]
      %{#{require module_filename}'
class #{class_name_for(filename)}
  include #{class_name_for(module_filename)}
end
}
    else
      %{class #{class_name_for(filename)}
  def call
    "#{filename} was called"
  end
end
}
    end
  end

  def module_content(filename, options)
    <<-BODY
module #{class_name_for(filename)}
  def call
    "#{filename} was called"
  end
end
    BODY
  end

  def class_name_for(filename)
    filename.gsub('.rb', '').gsub('lib/', '').gsub('spec/', '').classify
  end

  def spec_content(filename)
    <<-BODY
require 'spec_helper'
#{require filename}'

describe #{class_name_for(filename)} do
  it "can be called" do
    subject.call.should =~ /was called/
  end
end
    BODY
  end

  def require(filename)
    "require '#{filename.gsub('lib/', '')}"
  end

  def spec_name_for(filename)
    filename.gsub('.rb', '_spec.rb').gsub(/^lib/, 'spec')
  end

  def generate_module_filename
    'lib/my_module.rb'
  end

  def generate_class_filename
    "lib/test_class_#{Dsl.next(:class)}.rb"
  end

  def self.next(name)
    @sequences ||= {}
    @sequences[name] ||= 0
    @sequences[name] += 1
  end
end

World(Dsl)
