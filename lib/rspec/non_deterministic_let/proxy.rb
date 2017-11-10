require 'rspec/non_deterministic_let/helpers'

RSpec.configure do |config|
  config.include RSpec::NonDeterministicLet::Helpers
  config.extend RSpec::NonDeterministicLet::Helpers::ClassMethods
end
