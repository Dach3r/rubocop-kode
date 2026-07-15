# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Kode::NoArgumentAlignment, :config do
  it "registers an offense for extra spaces after a comma between arguments" do
    expect_offense(<<~RUBY)
      foo(1,               2)
            ^^^^^^^^^^^^^^ Use one space after comma between arguments.
    RUBY

    expect_correction(<<~RUBY)
      foo(1, 2)
    RUBY
  end

  it "does not register an offense for a single space after a comma" do
    expect_no_offenses(<<~RUBY)
      foo(1, 2)
    RUBY
  end

  it "does not register an offense for a single argument" do
    expect_no_offenses(<<~RUBY)
      foo(1)
    RUBY
  end

  it "does not register an offense when arguments span multiple lines" do
    expect_no_offenses(<<~RUBY)
      foo(1,
          2)
    RUBY
  end
end
