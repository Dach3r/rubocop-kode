# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Kode::NoNilReturn, :config do
  it "registers an offense for `return nil`" do
    expect_offense(<<~RUBY)
      def duration
        return nil unless started_at && finished_at
        ^^^^^^^^^^ Use `return` instead of `return nil`.

        finished_at - started_at
      end
    RUBY

    expect_correction(<<~RUBY)
      def duration
        return unless started_at && finished_at

        finished_at - started_at
      end
    RUBY
  end

  it "registers an offense for a bare `return nil`" do
    expect_offense(<<~RUBY)
      def foo
        return nil
        ^^^^^^^^^^ Use `return` instead of `return nil`.
      end
    RUBY

    expect_correction(<<~RUBY)
      def foo
        return
      end
    RUBY
  end

  it "does not register an offense for a bare `return`" do
    expect_no_offenses(<<~RUBY)
      def duration
        return unless started_at && finished_at

        finished_at - started_at
      end
    RUBY
  end

  it "does not register an offense for `return` with a non-nil value" do
    expect_no_offenses(<<~RUBY)
      def foo
        return false
      end
    RUBY
  end

  it "does not register an offense for `return nil, other`" do
    expect_no_offenses(<<~RUBY)
      def foo
        return nil, 1
      end
    RUBY
  end
end
