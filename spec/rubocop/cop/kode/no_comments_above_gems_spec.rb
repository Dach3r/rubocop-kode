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

  it "does not register an offense when there is no comment or blank line above a gem" do
    expect_no_offenses(<<~RUBY)
      gem "rails", "~> 8.1.3"
      gem "propshaft"
      gem "pg", "~> 1.1"
    RUBY
  end

  it "does not register an offense for a trailing comment on the previous gem" do
    expect_no_offenses(<<~RUBY)
      gem "puma", ">= 5.0" # some note
      gem "importmap-rails"
    RUBY
  end

  it "registers an offense for a blank line above a gem" do
    expect_offense(<<~RUBY)
      gem "propshaft"

      ^{} Do not leave a blank line above `gem` declarations.
      gem "puma", ">= 5.0"
    RUBY

    expect_correction(<<~RUBY)
      gem "propshaft"
      gem "puma", ">= 5.0"
    RUBY
  end

  it "registers a single offense for multiple contiguous blank lines above a gem" do
    expect_offense(<<~RUBY)
      gem "propshaft"

      ^{} Do not leave a blank line above `gem` declarations.

      gem "puma", ">= 5.0"
    RUBY

    expect_correction(<<~RUBY)
      gem "propshaft"
      gem "puma", ">= 5.0"
    RUBY
  end

  it "does not register an offense for a blank line separating source from the first gem" do
    expect_no_offenses(<<~RUBY)
      source "https://rubygems.org"

      gem "bootsnap", require: false
    RUBY
  end

  it "registers an offense when the first gem is directly below source with no blank line" do
    expect_offense(<<~RUBY)
      source "https://rubygems.org"
                                   ^{} Leave a blank line below the `source` declaration.
      gem "bootsnap", require: false
    RUBY

    expect_correction(<<~RUBY)
      source "https://rubygems.org"

      gem "bootsnap", require: false
    RUBY
  end

  it "registers an offense for a blank line below a comment, then flags the exposed comment on the next pass" do
    expect_offense(<<~RUBY)
      # unrelated comment

      ^{} Do not leave a blank line above `gem` declarations.
      gem "puma", ">= 5.0"
    RUBY

    # Autocorrect converges over multiple internal passes: first the blank
    # line goes, which then exposes the comment as directly above the gem.
    expect_correction(<<~RUBY)
      gem "puma", ">= 5.0"
    RUBY
  end
end
