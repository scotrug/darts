require 'darts/rspec/agent'

agent = Darts::RSpec::Agent.new(Darts::Mappings.new)
RSpec.configure do |config|
  config.before(:each) { agent.before_each(example) }
  config.after(:each) { agent.after_each(example) }
  config.after(:all) { agent.after_all }
end
