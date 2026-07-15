# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Kode::NoHashAlignment, :config do
  it "registers an offense for extra spaces after a hash rocket key" do
    expect_offense(<<~RUBY)
      { "foo"      => false }
             ^^^^^ Use one space after `=>` in hash pairs.
    RUBY

    expect_correction(<<~RUBY)
      { "foo" => false }
    RUBY
  end

  it "registers an offense for extra spaces after a colon key" do
    expect_offense(<<~RUBY)
      { foo:        1 }
            ^^^^^^^ Use one space after `:` in hash pairs.
    RUBY

    expect_correction(<<~RUBY)
      { foo: 1 }
    RUBY
  end

  it "does not register an offense for a single space" do
    expect_no_offenses(<<~RUBY)
      { "foo" => false, bar: 1 }
    RUBY
  end
end
