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
      bullet_list = []
      content.each { |li| bullet_list << bullet(li) }
      bullet_list
    end

    def number(content, number = 1)
      " #{number}. #{content}"
    end

    def numbers(*content)
      numbered_list = []
      current_number = 0
      content.each { |li| numbered_list << number(li, current_number += 1) }
      numbered_list
    end

    def link(label, url)
      "[#{label}](#{url})"
    end

    def code(content)
      "    #{content}"
    end

    def code_block(*content)
      block = []
      content.each { |c| block << code(c) }
      block
    end
  end
end
