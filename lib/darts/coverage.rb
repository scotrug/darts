require 'coverage'

module Darts
  Coverage = ::Coverage # until we need to support 1.8
end

Darts::Coverage.start
