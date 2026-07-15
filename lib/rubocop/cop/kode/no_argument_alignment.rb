# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoArgumentAlignment < Base
        extend AutoCorrector
        include RangeHelp

        MSG = "Use one space after comma between arguments."

        def on_send(node)
          check_argument_spacing(node)
        end
        alias on_csend on_send

        private

        def check_argument_spacing(node)
          args = node.arguments
          return if args.size < 2

          args.each_cons(2) do |arg1, arg2|
            next unless same_source_line?(arg1, arg2)

            between = source_between(arg1, arg2)
            next unless /\A,[ \t]{2,}\z/.match?(between)

            extra_range = range_between(
              arg1.source_range.end_pos + 1,
              arg2.source_range.begin_pos - 1
            )

            add_offense(extra_range) do |corrector|
              corrector.remove(extra_range)
            end
          end
        end

        def same_source_line?(arg1, arg2)
          arg1.loc.last_line == arg2.loc.line
        end

        def source_between(arg1, arg2)
          range_between(
            arg1.source_range.end_pos,
            arg2.source_range.begin_pos
          ).source
        end
      end
    end
  end
end
