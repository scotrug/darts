Given /^two classes, each with corresponding RSpec specs:$/ do |table|
  table.raw.flatten.each do |filename|
    write_class_with_spec(filename)
  end
end

Given /^Darts has watched the specs run (once|twice)$/ do |count|
  count.times { run_specs_with_darts }
end

Transform /^once|twice$/ do |count|
  { 'once' => 1,
    'twice' => 2 
  }[count] || raise("I don't understand '#{count}")
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
