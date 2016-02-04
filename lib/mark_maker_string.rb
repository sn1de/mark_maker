require 'mark_maker'

# adds several basic string to markdown conversion methods
class String
  def line_for(underscore)
    underscore * size
  end

  def header1
    "#{self}\n#{line_for('=')}"
  end

  def header2
    "#{self}\n#{line_for('-')}"
  end

  def header3
    "### #{self}"
  end

  def bullet
    " - #{self}"
  end

  def number(number = 1)
    " #{number}. #{self}"
  end

  def code
    "    #{self}"
  end

  def code_span
    "#{MarkMaker::CODE_TIC}#{self}#{MarkMaker::CODE_TIC}"
  end

  def emphasis
    "#{MarkMaker::EMPHASIS}#{self}#{MarkMaker::EMPHASIS}"
  end

  def strong
    MarkMaker::EMPHASIS * 2 + self + MarkMaker::EMPHASIS * 2
  end
end
