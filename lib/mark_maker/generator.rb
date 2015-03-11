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

    def bullet(content)
      " - #{content}"
    end

    def number(content)
      " 1. #{content}"
    end

    def link(label, url)
      "[#{label}](#{url})"
    end

    def code(content)
      "    #{content}"
    end
  end
end
