# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoNilReturn < Base
        extend AutoCorrector
        include RangeHelp

        MSG = "Use `return` instead of `return nil`."

        def on_return(node)
          return unless node.arguments.one?

          arg = node.arguments.first

          return unless arg.nil_type?

          add_offense(node) do |corrector|
            corrector.remove(range_between(node.loc.keyword.end_pos, node.source_range.end_pos))
          end
        end
      end
    end
  end
end
