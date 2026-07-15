# frozen_string_literal: true

require "rubocop"
require "rubocop/rspec/support"
require "rubocop-kode"

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
