module MarkMaker
  # Generator is the workhorse of the MarkMaker utility. It provides
  # line by line generation of markdown output.
  class Generator
    def line_for(underscore, content)
      underscore * content.size
    end

    def header1(title)
      "#{title}\n#{line_for('=', title)}"
    end

    def header2(title)
      "#{title}\n#{line_for('-', title)}"
    end

    def header3(title)
      "### #{title}"
    end

    def bullet(content)
      " - #{content}"
    end

    def bullets(*content)
      content.map { |li| bullet(li) }
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

    def block_quote(*content)
      content.map { |c| "#{BLOCK_QUOTE} #{c}"}
    end
  end
end
