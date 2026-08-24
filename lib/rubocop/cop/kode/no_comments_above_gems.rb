# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoCommentsAboveGems < Base
        extend AutoCorrector
        include RangeHelp

        MSG = "Do not place comments above `gem` declarations."

        RESTRICT_ON_SEND = [:gem].freeze

        def on_send(node)
          comments = leading_comments(node)
          return if comments.empty?

          range = comments.first.location.expression.join(comments.last.location.expression)

          add_offense(range) do |corrector|
            corrector.remove(range_by_whole_lines(range, include_final_newline: true))
          end
        end

        private

        def leading_comments(node)
          comments = []
          line = node.first_line - 1

          while (comment = whole_line_comment_on(line))
            comments.unshift(comment)
            line -= 1
          end

          comments
        end

        def whole_line_comment_on(line)
          processed_source.comments.find do |comment|
            comment.location.line == line && whole_line_comment?(comment)
          end
        end

        def whole_line_comment?(comment)
          processed_source.raw_source.lines[comment.location.line - 1].to_s.match?(/\A[ \t]*#/)
        end
      end
    end
  end
end
