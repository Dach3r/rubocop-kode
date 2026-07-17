# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::SingleLineMethods, :config do
  let(:cop_config) { { "AllowIfMethodIsEmpty" => false } }

  it "registers an offense for a single-line empty method definition" do
    expect_offense(<<~RUBY)
      def index; end
      ^^^^^^^^^^^^^^ Avoid single-line method definitions.
    RUBY

    expect_correction(<<~RUBY)
      def index;#{" "}
      end
    RUBY
  end

  it "does not register an offense for a multi-line method definition" do
    expect_no_offenses(<<~RUBY)
      def index
      end
    RUBY
  end
end
