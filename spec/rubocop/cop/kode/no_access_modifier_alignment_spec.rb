# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Kode::NoAccessModifierAlignment, :config do
  it "registers an offense when code after a bare access modifier is not aligned with it" do
    expect_offense(<<~RUBY)
      class Foo
        private
          def smooth; end
      ^^^^ Align code with the surrounding `private` access modifier.
      end
    RUBY

    expect_correction(<<~RUBY)
      class Foo
        private
        def smooth; end
      end
    RUBY
  end

  it "does not register an offense when code is aligned with the access modifier" do
    expect_no_offenses(<<~RUBY)
      class Foo
        private

        def smooth; end
      end
    RUBY
  end

  it "stops checking once a new bare access modifier appears" do
    expect_no_offenses(<<~RUBY)
      class Foo
        private

        def smooth; end

        public

        def loud; end
      end
    RUBY
  end
end
