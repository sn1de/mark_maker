
# adds several basic string to markdown conversion methods
class String
  def line_for(underscore)
    underscore * size
  end

  def header(level)
    case level
    when 1
      "#{self}\n#{line_for('=')}"
    when 2
      "#{self}\n#{line_for('-')}"
    when 3..6
      "#{'#' * level} #{self}"
    else
      raise ArgumentError, "Header level must be between 1 and 6"
    end
  end

  (1..6).each do |level|
    define_method("header#{level}") do
      header(level)
    end
  end

  # def header1
  #   "#{self}\n#{line_for('=')}"
  # end
  #
  # def header2
  #   "#{self}\n#{line_for('-')}"
  # end
  #
  # def header3
  #   "### #{self}"
  # end
  #
  # def header4
  #   "#### #{self}"
  # end
  #
  # def header5
  #   "##### #{self}"
  # end
  #
  # def header6
  #   "###### #{self}"
  # end

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
