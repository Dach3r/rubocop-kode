# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Kode::NoCommentsAboveGems, :config do
  it "registers an offense for a comment directly above a gem" do
    expect_offense(<<~RUBY)
      # Use Active Model has_secure_password
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not place comments above `gem` declarations.
      gem "bcrypt", "~> 3.1.7"
    RUBY

    expect_correction(<<~RUBY)
      gem "bcrypt", "~> 3.1.7"
    RUBY
  end

  it "registers a single offense for multiple contiguous comment lines above a gem" do
    expect_offense(<<~RUBY)
      # Windows does not include zoneinfo files,
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not place comments above `gem` declarations.
      # so bundle the tzinfo-data gem
      gem "tzinfo-data", platforms: %i[ windows jruby ]
    RUBY

    expect_correction(<<~RUBY)
      gem "tzinfo-data", platforms: %i[ windows jruby ]
    RUBY
  end

  it "does not register an offense when there is no comment above a gem" do
    expect_no_offenses(<<~RUBY)
      gem "rails", "~> 8.1.3"
      gem "propshaft"
      gem "pg", "~> 1.1"
    RUBY
  end

  it "does not register an offense for a comment separated by a blank line" do
    expect_no_offenses(<<~RUBY)
      # unrelated comment

      gem "puma", ">= 5.0"
    RUBY
  end

  it "does not register an offense for a trailing comment on the previous gem" do
    expect_no_offenses(<<~RUBY)
      gem "puma", ">= 5.0" # some note
      gem "importmap-rails"
    RUBY
  end
end
