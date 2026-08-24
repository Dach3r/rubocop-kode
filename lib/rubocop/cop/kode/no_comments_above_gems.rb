# frozen_string_literal: true

module RuboCop
  module Cop
    module Kode
      class NoCommentsAboveGems < Base
        extend AutoCorrector
        include RangeHelp

        COMMENT_MSG = "Do not place comments above `gem` declarations."
        BLANK_LINE_MSG = "Do not leave a blank line above `gem` declarations."

        RESTRICT_ON_SEND = [:gem].freeze

        def on_send(node)
          comments = leading_comments(node)
          top_line = comments.empty? ? node.first_line : comments.first.location.line

          check_comments(comments)
          check_blank_lines(top_line)
        end

        private

        def check_comments(comments)
          return if comments.empty?

          range = comments.first.location.expression.join(comments.last.location.expression)

          add_offense(range, message: COMMENT_MSG) do |corrector|
            corrector.remove(range_by_whole_lines(range, include_final_newline: true))
          end
        end

        def check_blank_lines(top_line)
          last_blank_line = top_line - 1

          return unless blank_line?(last_blank_line)

          first_blank_line = last_blank_line
          first_blank_line -= 1 while blank_line?(first_blank_line - 1)

          range = range_between(
            processed_source.buffer.line_range(first_blank_line).begin_pos,
            processed_source.buffer.line_range(top_line).begin_pos
          )

          add_offense(range, message: BLANK_LINE_MSG) do |corrector|
            corrector.remove(range)
          end
        end

        def blank_line?(line)
          line >= 1 && processed_source.raw_source.lines[line - 1].to_s.strip.empty?
        end

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
