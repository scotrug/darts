require 'darts/memory'
require 'darts/rspec/recording'

module Darts
  module RSpec
    class << self
      def install_hooks
        ::RSpec.configure do |config|
          config.before(:each) { Darts::RSpec.before(example) }
          config.after(:each) { Darts::RSpec.after(example) }
          config.after(:all) { Darts::Memory.save }
        end
      end

      def before(example)
        @recording = Recording.new(example)
      end

      def after(example)
        Memory.store @recording
      end
    end
  end
end

Darts::RSpec.install_hooks
