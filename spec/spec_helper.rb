require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/rea-robot'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
