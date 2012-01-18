Given /^two classes, each with corresponding RSpec specs:$/ do |table|
  table.raw.flatten.each do |filename|
    write_class_with_spec :filename => filename
  end
end

Given /^Darts has watched the specs run$/ do
  run_specs_with_darts
end

Given /^Darts has watched the specs run (#{COUNT})$/ do |count|
  count.times { run_specs_with_darts }
end

When /^I ask Darts which specs touch "([^"]*)"$/ do |source_file|
  darts :into, source_file
end

When /^I ask Darts to show the mappings$/ do
  darts :mappings
end

Then /^I should be given this list:$/ do |table|
  output_from_darts.split("\n").should == table.raw.flatten
end

Then /^I should see:$/ do |string|
  output_from_darts.should =~ Regexp.new(string)
end

Given /^a module which is touched by two separate RSpec specs$/ do
  @module = write_module
  2.times do
    write_class_with_spec :include_module => @module
  end
end

When /^I ask Darts which specs touch the module$/ do
  darts :into, @module
end

Then /^I should be given a list with both specs$/ do
  output_from_darts.strip.should == spec_locations.join(' ')
end

