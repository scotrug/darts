require 'darts/rspec/agent'

agent = Darts::RSpec::Agent.new(Darts::Mappings.new)
RSpec.configure do |config|
  config.before(:each) { agent.before_each(example) }
  config.after(:each) { agent.after_each(example) }
end

at_exit { agent.at_exit }
