# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Kode::NoAssignmentAlignment, :config do
  it "registers an offense for extra spaces before an lvasgn operator" do
    expect_offense(<<~RUBY)
      bar    = 2
         ^^^ Use one space before `=` in assignments.
    RUBY

    expect_correction(<<~RUBY)
      bar = 2
    RUBY
  end

  it "registers an offense for extra spaces before an ivasgn operator" do
    expect_offense(<<~RUBY)
      @foo   = 1
          ^^ Use one space before `=` in assignments.
    RUBY

    expect_correction(<<~RUBY)
      @foo = 1
    RUBY
  end

  it "registers an offense for extra spaces before a setter operator" do
    expect_offense(<<~RUBY)
      self.ends_at   = 1.month.from_now
                  ^^ Use one space before `=` in assignments.
    RUBY

    expect_correction(<<~RUBY)
      self.ends_at = 1.month.from_now
    RUBY
  end

  it "does not register an offense for a single space" do
    expect_no_offenses(<<~RUBY)
      bar = 2
      @foo = 1
      self.ends_at = 1.month.from_now
    RUBY
  end
end
