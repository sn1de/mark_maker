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
end
