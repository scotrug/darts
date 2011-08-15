require 'support/fruit_examples'
require 'apple'

describe Apple do
  it_should_behave_like "a fruit"

  it { should have_pips }
end
