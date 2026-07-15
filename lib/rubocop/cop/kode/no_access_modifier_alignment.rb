# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoAccessModifierAlignment < Base
        extend AutoCorrector
        include RangeHelp

        MSG = "Align code with the surrounding `%<modifier>s` access modifier."

        def on_send(node)
          check_access_modifier_alignment(node) if node.bare_access_modifier?
        end
        alias on_csend on_send

        private

        def check_access_modifier_alignment(node)
          parent = node.parent
          return unless parent&.begin_type?

          siblings = parent.children
          index = siblings.index { |sibling| sibling.equal?(node) }
          modifier_column = node.loc.expression.column

          siblings[(index + 1)..].each do |sibling|
            break if sibling.send_type? && sibling.bare_access_modifier?

            sibling_column = sibling.loc.expression.column
            next if sibling_column == modifier_column

            add_offense(indentation_range(sibling), message: format(MSG, modifier: node.method_name)) do |corrector|
              AlignmentCorrector.correct(corrector, processed_source, sibling, modifier_column - sibling_column)
            end
          end
        end

        def indentation_range(node)
          begin_pos = node.source_range.begin_pos
          range_between(begin_pos - node.loc.expression.column, begin_pos)
        end
      end
    end
  end
end
