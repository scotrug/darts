Given /^two classes, each with corresponding RSpec specs:$/ do |table|
  table.raw.flatten.each do |filename|
    write_class_with_spec(filename)
  end
end

Given /^Darts has watched the specs run once$/ do
  run_specs_with_darts
end

When /^I ask Darts which specs touch "([^"]*)"$/ do |source_file|
  darts :into, source_file
end

When /^I modify "([^"]*)"$/ do |filename|
  touch(filename)
end

When /^I ask Darts which specs I should run$/ do
  darts :needed
end

Then /^I should be given this list:$/ do |table|
  table.raw.flatten.should == output_from_darts.split("\n")
end
