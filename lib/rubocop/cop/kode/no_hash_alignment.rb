# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoHashAlignment < Base
        extend AutoCorrector
        include RangeHelp

        MSG = "Use one space after `%<op>s` in hash pairs."

        def on_pair(node)
          if node.hash_rocket?
            check_hash_rocket_spacing(node)
          else
            check_colon_spacing(node)
          end
        end

        private

        def check_hash_rocket_spacing(node)
          key = node.key
          op_range = node.loc.operator

          return unless key.loc.last_line == op_range.line

          between = range_between(key.source_range.end_pos, op_range.begin_pos).source
          return unless /\A[ \t]{2,}\z/.match?(between)

          extra_range = range_between(
            key.source_range.end_pos,
            op_range.begin_pos - 1
          )

          add_offense(extra_range, message: format(MSG, op: "=>")) do |corrector|
            corrector.remove(extra_range)
          end
        end

        def check_colon_spacing(node)
          key = node.key
          val = node.value

          return unless key.loc.last_line == val.loc.line
          return if val.source_range.begin_pos <= key.source_range.end_pos

          between = range_between(key.source_range.end_pos, val.source_range.begin_pos).source
          return unless /\A:[ \t]{2,}\z/.match?(between)

          extra_range = range_between(
            key.source_range.end_pos + 1,
            val.source_range.begin_pos - 1
          )

          add_offense(extra_range, message: format(MSG, op: ":")) do |corrector|
            corrector.remove(extra_range)
          end
        end
      end
    end
  end
end
