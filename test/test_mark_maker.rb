require 'unindent'
require 'simplecov'
SimpleCov.start

require 'minitest_helper'

class TestMarkMaker < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MarkMaker::VERSION
  end

  def test_bulleted_list_generation
    content = ["gold", "silver", "bronze"]
    gen = MarkMaker::Generator.new
    markup = gen.bullets(*content)
    assert(markup.length == content.length, "The number of lines of content and markup is not equal.")
    content.zip(markup).each do |c, m|
      assert_match(/^\s-\s#{c}$/, m)
    end
  end

  def test_numbered_list_generation
    content = ["1", "2", "3"]
    gen = MarkMaker::Generator.new
    markup = gen.numbers(*content)
    assert(markup.length == content.length, "The number of lines of content and markup is not equal.")
    content.zip(markup).each do |c, m|
      assert_match(/^\s#{c}\.\s#{c}$/, m)
    end
  end

  def test_link_generation
    label = "anywhere"
    url = "http://www.yahoo.com"
    gen = MarkMaker::Generator.new
    markup = gen.link(label, url)
    assert_match(/^\[#{label}\]\(#{url}\)$/, markup)
  end

  def test_image_generation
    path = "https://travis-ci.org/sn1de/mark_maker.svg?branch=master"
    alt = "Mark Maker build status from Travis continuous integration"
    title = "Build Status"
    gen = MarkMaker::Generator.new
    markup = gen.image(alt, path, title)
    assert_match(/^!\[#{Regexp.quote(alt)}\]\(#{Regexp.quote(path)}\s#{Regexp.quote(title)}\)/, markup)
  end

  def test_code_block_generation
    content = ["a = 1", "b = 2", "c = 3"]
    gen = MarkMaker::Generator.new
    markup = gen.code_block(*content)
    assert(markup.length == content.length, "The number of lines of content and markup is not equal.")
    content.zip(markup).each do |c, m|
      assert_match(/^\s{4}#{c}$/, m)
    end
  end

  def test_fenced_code_block_generation
    content = ["a = 1", "b = 2", "c = 3"]
    gen = MarkMaker::Generator.new
    markup = gen.fenced_code_block(*content)
    assert(markup.length == content.length + 2, "Length of markup should equal the content plus the two fences.")
    assert(markup.slice(1, content.length) == content, "The code body of the markup should match the original content exactly.")
    assert(markup.first == MarkMaker::FENCE, "Markup should start with the code fence.")
    assert(markup.last == MarkMaker::FENCE, "Markup should end with the code fence.")
  end

  def test_fenced_code_language_generation
    content = ["a = 1", "b = 2", "c = 3"]
    lang = "ruby"
    gen = MarkMaker::Generator.new
    markup = gen.fenced_code_language(lang, *content)
    assert(markup.length == content.length + 2, "Length of markup should equal the content plus the two fences.")
    assert(markup.slice(1, content.length) == content, "The code body of the markup should match the original content exactly.")
    assert(markup.first == MarkMaker::FENCE + lang, "Markup should start with the code fence and the language.")
    assert(markup.last == MarkMaker::FENCE, "Markup should end with the code fence.")
  end

  def test_table_header_generation
    content = ["Col One", "Col Two", "Col 3"]
    gen  = MarkMaker::Generator.new
    line1, line2 = gen.table_header(*content)
    assert_match(/^\|#{Regexp.quote(content[0])}\|#{Regexp.quote(content[1])}\|#{Regexp.quote(content[2])}\|$/, line1)
    assert_match(/^\|-{#{content[0].size}}\|-{#{content[1].size}}\|-{#{content[2].size}}\|$/, line2)
  end

  def test_table_row_generation
    content = ["A", "Two", "$3.99"]
    gen  = MarkMaker::Generator.new
    row = gen.table_row(*content)
    assert_match(/^\|#{Regexp.quote(content[0])}\|#{Regexp.quote(content[1])}\|#{Regexp.quote(content[2])}\|$/, row)
  end

  def test_block_quote_generation
    content = ["Line 1", "Line 2", "Line 3"]
    gen = MarkMaker::Generator.new
    markup = gen.block_quote(*content)
    content.zip(markup).each do |c, m| 
      assert_match(/^> #{Regexp.quote(c)}$/, m)
    end
  end

  # This test should always pass. It is here simple to validate the proper
  # usage of a heredoc as a test method

  def test_heredoc_method
    desired_output = <<-EOS.unindent
      This should contain no indents.

      It should be 3 lines long.
    EOS
    test_output = "This should contain no indents.\n\nIt should be 3 lines long.\n"
    assert_equal(desired_output, test_output, "Output must exactly match.")
  end

  def test_join
    assert_equal("abc", ["a", "b", "c"].join)
  end

  def test_column_width
    gen = MarkMaker::Generator.new
    assert_equal(5, gen.column_width("One", "Two", "12345", "Four"))
  end

  def test_pretty_table_generation
    pretty_table = <<-EOS.unindent
      |Col One|Col Two|Col Three|
      |:------|:-----:|--------:|
      |First  |   A   |    $3.99|
      |Second |  BC   |   $14.00|
      |Third  | DEFGH |$1,034.50|
    EOS
    table_data = [
      ["Col One", "Col Two", "Col Three"],
      [":-", ":-:", "-:"],
      ["First", "A", "$3.99"],
      ["Second", "BC", "$14.00"],
      ["Third", "DEFGH", "$1,034.50"]
    ]
  gen = MarkMaker::Generator.new
    markup = gen.table(*table_data)
    assert_equal(pretty_table, markup.join)
  end

  def test_left_justify
    test_justified = ["a   ", "bbb ", "cc  ", "d  d"]
    gen = MarkMaker::Generator.new
    justified = gen.left_justify(' ', "a", "bbb", "cc", "d  d")
    assert_equal(test_justified, justified)
  end

  def test_right_justify
    test_justified = ["  a", "bbb", " cc"]
    gen = MarkMaker::Generator.new
    gen_justified = gen.right_justify(' ', "a", "bbb", "cc")
    assert_equal(test_justified, gen_justified)
  end

  def test_center_justify
    test_justified = ["  a  ", "bbbbb", " ccc ", " dd  ", "e ee "]
    gen = MarkMaker::Generator.new
    gen_justified = gen.center_justify(' ', "a", "bbbbb", "ccc", "dd", "e ee")
    assert_equal(test_justified, gen_justified)
  end

  def test_centered_margins
    gen = MarkMaker::Generator.new
    left, right = gen.centered_margins(5, "cc")
    assert_equal(1, left)
    assert_equal(2, right)
  end

  def test_justify_detection
    gen = MarkMaker::Generator.new
    
    assert(gen.justification?(":-"))
    assert(gen.justification?(":-:"))
    assert(gen.justification?("-:"))
    assert(gen.justification?(":------"))
    assert(gen.justification?(":------:"))
    assert(gen.justification?(":-:"))
    assert(gen.justification?("------:"))
    refute(gen.justification?("stuff"))
    refute(gen.justification?("stuff:it"))
    refute(gen.justification?(":bad news"))
    refute(gen.justification?("bad news:"))
    refute(gen.justification?("---"))
    refute(gen.justification?("-"))
  end

  def test_left_justification_indicators
    assert_match(MarkMaker::LEFT_JUSTIFY, ":-")
    assert_match(MarkMaker::LEFT_JUSTIFY, ":---------")
    refute_match(MarkMaker::LEFT_JUSTIFY, "-")
    refute_match(MarkMaker::LEFT_JUSTIFY, "-:")
    refute_match(MarkMaker::LEFT_JUSTIFY, ":--:")
    refute_match(MarkMaker::LEFT_JUSTIFY, "-----")
    refute_match(MarkMaker::LEFT_JUSTIFY, "")
    refute_match(MarkMaker::LEFT_JUSTIFY, ":")
    refute_match(MarkMaker::LEFT_JUSTIFY, "::")
  end

  def test_right_justification_indicators
    assert_match(MarkMaker::RIGHT_JUSTIFY, "-:")
    assert_match(MarkMaker::RIGHT_JUSTIFY, "---------:")
    refute_match(MarkMaker::RIGHT_JUSTIFY, "-")
    refute_match(MarkMaker::RIGHT_JUSTIFY, ":---")
    refute_match(MarkMaker::RIGHT_JUSTIFY, ":--:")
    refute_match(MarkMaker::RIGHT_JUSTIFY, "-----")
    refute_match(MarkMaker::RIGHT_JUSTIFY, "")
    refute_match(MarkMaker::RIGHT_JUSTIFY, ":")
    refute_match(MarkMaker::RIGHT_JUSTIFY, "::")
  end

  def test_center_justification_indicators
    assert_match(MarkMaker::CENTER_JUSTIFY, ":-:")
    assert_match(MarkMaker::CENTER_JUSTIFY, ":---------:")
    assert_match(MarkMaker::CENTER_JUSTIFY, "::")
    refute_match(MarkMaker::CENTER_JUSTIFY, "-")
    refute_match(MarkMaker::CENTER_JUSTIFY, "-:")
    refute_match(MarkMaker::CENTER_JUSTIFY, ":--")
    refute_match(MarkMaker::CENTER_JUSTIFY, "-----")
    refute_match(MarkMaker::CENTER_JUSTIFY, "")
    refute_match(MarkMaker::CENTER_JUSTIFY, ":")
  end

  def test_fill_justify
    gen = MarkMaker::Generator.new
    filled = gen.fill_justify('-', 'header', ":-:", "more", "stuff")
    assert_equal(":----:", filled[1])
  end

  # def test_determine_justification
  #   justifiers = ["-:", ":-", ":--:", "---:", ":---", "::", "---", "zzz"]
  #   justifiers.each do |j|
  #     case j
  #     when MarkMaker::RIGHT_JUSTIFY
  #       puts "#{j} will be right justified"
  #     when MarkMaker::LEFT_JUSTIFY
  #       puts "#{j} will be left justified"
  #     when MarkMaker::CENTER_JUSTIFY
  #       puts "#{j} will be center justified"
  #     else
  #       puts "#{j} is an invalid justification indicator"
  #     end
  #   end
  # end

  # def test_right_justify_table_column
  #   right_justified = <<-EOS.unindent
  #     |  Justified|
  #     |----------:|
  #     |          a|
  #     |bbbbbbbbbbb|
  #     |        ccc|
  #   EOS
  #   gen = MarkMaker::Generator.new
  #   markdown = gen.table("Justified", ?????)
  #   assert_equal(right_justified, markup, "Column content should be right justified.")
  # end


  # def test_pretty_table_justified_generation
  #   pretty_table = <<-EOS.unindent
  #     |Col One|Col Two|Col Three |Data Sized   |
  #     |-------|-------|----------|-------------|
  #     |First  |   A   |     $3.99|xxxxxxxxxxxxx|
  #     |Second |   BC  |    $14.00|y            |
  #     |Third  |  DEF  | $1,034.50|z            |
  #     |Fourth |GHIJKLM|$10,123.45|a            |
  #   EOS

  #   markup = 'nada'
  #   assert_equal(pretty_table, markup)
  # end
end

