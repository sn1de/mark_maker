require "mark_maker/version"

module MarkMaker

  def MarkMaker.line_for(underscore, content)
    underscore * content.size
  end

  def MarkMaker.header1(title)
    "#{title}\n#{MarkMaker.line_for("=", title)}"
  end

  def MarkMaker.header2(title)
    "#{title}\n#{MarkMaker.line_for("-", title)}"
  end

  def MarkMaker.bullet(content)
    " - #{content}"
  end

  def MarkMaker.link(label, url)
    "[#{label}](#{url})"
  end

end
