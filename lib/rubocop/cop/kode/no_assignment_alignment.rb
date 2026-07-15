# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoAssignmentAlignment < Base
        extend AutoCorrector
        include RangeHelp

        MSG = "Use one space before `=` in assignments."

        def on_send(node)
          check_setter_spacing(node) if node.setter_method?
        end
        alias on_csend on_send

        def on_lvasgn(node)
          check_lhs_assignment_spacing(node, node.loc.name)
        end

        def on_ivasgn(node)
          check_lhs_assignment_spacing(node, node.loc.name)
        end

        private

        def check_setter_spacing(node)
          op = node.loc.operator
          selector = node.loc.selector
          return unless op && selector
          return unless selector.last_line == op.line

          between = range_between(selector.end_pos, op.begin_pos).source
          return unless /\A[ \t]{2,}\z/.match?(between)

          extra_range = range_between(selector.end_pos, op.begin_pos - 1)
          add_offense(extra_range) do |corrector|
            corrector.remove(extra_range)
          end
        end

        def check_lhs_assignment_spacing(node, name_loc)
          op = node.loc.operator
          return unless op && name_loc
          return unless name_loc.last_line == op.line

          between = range_between(name_loc.end_pos, op.begin_pos).source
          return unless /\A[ \t]{2,}\z/.match?(between)

          extra_range = range_between(name_loc.end_pos, op.begin_pos - 1)
          add_offense(extra_range) do |corrector|
            corrector.remove(extra_range)
          end
        end
      end
    end
  end
end
