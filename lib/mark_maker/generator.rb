
module MarkMaker
  # Generator is the workhorse of the MarkMaker utility. It provides
  # line by line generation of markdown output.
  class Generator
    # Justification indicators are a bit of a special case, because the way
    # they actually work is the colon's proximity to the vertical | bars marking
    # the table cells. This means that the center justification indicator, for
    # example :-:, must have the colon directly adjacent to the left | and the
    # right | in order to take effect, like so |:-:|. Any whitespace on either
    # side will cause the center justification to be ignored and default to
    # left justification. So the following *will not* work, |:-:   | or | :-: |.
    # In fact the following, |   :-:|, will result in right justification. This
    # means we must fill out justification indicators, not just pad them out
    # with spaces, in order for justification markers to look good in our
    # native markdown output (an important consideration in itself) as well
    # as being honored and generating the intended HTML (both being equally
    # important in the MarkDown philosophy).

    # detect if the given table cell content is a justification indicator
    def justification?(cell)
      cell =~ MarkMaker::RIGHT_JUSTIFY ||
        cell =~ MarkMaker::LEFT_JUSTIFY ||
        cell =~ MarkMaker::CENTER_JUSTIFY
    end

    # Inspect the cell contents and return a justification indicator
    # as the fill element if the cell is a justification directive.
    def justified_fill(c, fill)
      justification?(c) ? '-' : fill
    end

    def bullets(*content)
      content.map(&:bullet)
    end

    def number(content, number = 1)
      " #{number}. #{content}"
    end

    def numbers(*content)
      current_number = 0
      content.map { |li| number(li, current_number += 1) }
    end

    def link(label, url)
      "[#{label}](#{url})"
    end

    def code(content)
      "    #{content}"
    end

    def code_span(content)
      "#{CODE_TIC}#{content}#{CODE_TIC}"
    end

    def code_block(*content)
      content.map { |c| code(c) }
    end

    # creates a github flavored markdown fenced code block
    def fenced_code_block(*content)
      block = *FENCE
      block.push(*content)
      block << FENCE
    end

    # creates a github flavored markdown fenced code block that
    # specifies the language for syntax highlighting purposes
    def fenced_code_language(lang, *content)
      block = *FENCE + lang
      block.push(*content)
      block << FENCE
    end

    def emphasis(content)
      "#{EMPHASIS}#{content}#{EMPHASIS}"
    end

    def strong(content)
      EMPHASIS * 2 + content + EMPHASIS * 2
    end

    def table_header(*content)
      [
        content.inject("|") { |a, e| a + "#{e}|" },
        content.inject("|") { |a, e| a + "-" * e.size + "|" }
      ]
    end

    def table_row(*content)
      content.inject("|") { |a, e| a << e << "|" }
    end

    # Table will treat the first line of content as the table header. It
    # will also assess each 'column' and derive the width from the largest
    # cell value, including the header. Justification can be passed in
    # optionally.

    def table(*content)
      columns = content.transpose
      justified = columns.map { |c| justify(*c) }
      content = justified.transpose
      table = []
      # if content.size >= 1
      #   header, separator = table_header(*content[0])
      #   table << header << separator
      # end
      content[0, content.size].each { |c| table << table_row(*c) }
      table.map { |t| t + "\n" }
    end

    def block_quote(*content)
      content.map { |c| "#{BLOCK_QUOTE} #{c}" }
    end

    def justify(*content)
      # check for a justification marker in the second row
      case content[1]
      when MarkMaker::RIGHT_JUSTIFY
        right_justify(' ', *content)
      when MarkMaker::LEFT_JUSTIFY
        left_justify(' ', *content)
      when MarkMaker::CENTER_JUSTIFY
        center_justify(' ', *content)
      else
        # no justification indicator was found, use a default
        left_justify(' ', *content)
      end
    end

    def left_justify(fill, *content)
      width = column_width(*content)

      content.map { |c| c + justified_fill(c, fill) * (width - c.length) }
    end

    def right_justify(fill, *content)
      width = column_width(*content)

      content.map { |c| justified_fill(c, fill) * (width - c.length) + c }
    end

    def center_justify(fill, *content)
      width = column_width(*content)

      content.map do |c|
        if justification?(c)
          # special case here, as justification must be filled from
          # the middle out in order to meet the markdown spec requirements
          # that will trigger proper justification
          f = []
          f << c
          f << 'a' * width
          fill_justify(justified_fill(c, fill), *f)[0]
        else
          left, right = centered_margins(width, c)
          justified_fill(c, fill) * left + c + justified_fill(c, fill) * right
        end
      end
    end

    # split the cell in two and then add the fill character
    # to the end of the first half of the cell to reach the
    # justified width
    def fill_justify(fill, *content)
      width = column_width(*content)
      content.map do |c|
        c.insert(c.length / 2, fill * (width - c.length))
      end
    end

    def column_width(*content)
      content.reduce { |a, e| a.length > e.length ? a : e } .length
    end

    def centered_margins(width, content)
      space = width - content.length
      base_margin = space / 2
      remainder_margin = width - content.length - base_margin * 2
      [
        base_margin,
        base_margin + remainder_margin
      ]
    end
  end
end
