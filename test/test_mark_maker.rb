require 'minitest_helper'

class TestMarkMaker < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MarkMaker::VERSION
  end

  def test_header1_generation
    title = "abc123"
    gen = MarkMaker::Generator.new
    markup = gen.header1(title)
    assert_match(/^={#{title.size}}$/, markup)
    assert_match(/^#{title}$/, markup)
    assert_match(/^#{title}\n={#{title.size}}$/, markup)
  end

  def test_header2_generation
    title = "abc123"
    gen = MarkMaker::Generator.new
    markup = gen.header2(title)
    assert_match(/^-{#{title.size}}$/, markup)
    assert_match(/^#{title}$/, markup)
    assert_match(/^#{title}\n-{#{title.size}}$/, markup)
  end

  def test_header3_generation
    title = "abc123"
    gen = MarkMaker::Generator.new
    markup = gen.header3(title)
    assert_match(/###\s#{title}/, markup)
  end

  def test_bullet_generation
    content = "This is a bullet"
    gen = MarkMaker::Generator.new
    markup = gen.bullet(content)
    assert_match(/^ - #{content}$/, markup)
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
  def test_number_generation
    content = "Number this line"
    gen = MarkMaker::Generator.new
    markup = gen.number(content)
    assert_match(/^\s\d\.\s#{content}$/, markup)
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

  def test_code_generation
    content = "var = code()"
    gen = MarkMaker::Generator.new
    markup = gen.code(content)
    assert_match(/\s{4}var = code\(\)$/, markup)
  end

  def test_code_span_generation
    gen = MarkMaker::Generator.new
    markup = "Some #{gen.code_span('a = b + c')} here."
    assert_match(/^Some #{MarkMaker::CODE_TIC}a = b \+ c#{MarkMaker::CODE_TIC} here.$/, markup)
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

  def test_emphasis_generation
    content = "emphasize this"
    gen = MarkMaker::Generator.new
    markup = gen.emphasis(content)
    assert_match(/^#{Regexp.quote(MarkMaker::EMPHASIS)}#{content}#{Regexp.quote(MarkMaker::EMPHASIS)}$/, markup)
  end

  def test_strong_generation
    content = "strong stuff"
    gen = MarkMaker::Generator.new
    markup = gen.strong(content)
    assert_match(/^#{Regexp.quote(MarkMaker::EMPHASIS * 2)}#{content}#{Regexp.quote(MarkMaker::EMPHASIS * 2)}$/, markup)
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
    desired_output = <<-EOS.strip_heredoc
      This should contain no intents.

      It should be 3 lines long.
    EOS
    test_output = "This should contain no intents.\n\nIt should be 3 lines long.\n"
    assert_equal(desired_output, test_output, "Output must exactly match.")
  end

  def test_column_width
    gen = MarkMaker::Generator.new
    assert_equal(5, gen.column_width("One", "Two", "12345", "Four"))
  end

  def test_pretty_table_generation
    pretty_table = <<-EOS.strip_heredoc
      |Col One|Col Two|Col Three|
      |-------|-------|---------|
      |First  |A      |$3.99    |
      |Second |BC     |$14.00   |
    EOS
    table_data = [
      ["Col One", "Col Two", "Col Three"],
      ["First", "A", "$3.99"],
      ["Second", "BC", "$14.00"]
    ]
    gen = MarkMaker::Generator.new
    markup = gen.table(*table_data)
    assert_equal(pretty_table, markup)
  end

  def test_left_justify
    test_justified = ["a  ", "bbb", "cc "]
    gen = MarkMaker::Generator.new
    justified = gen.left_justify("a", "bbb", "cc")
    assert_equal(test_justified, justified)
  end

  def test_right_justify
    test_justified = ["  a", "bbb", " cc"]
    gen = MarkMaker::Generator.new
    gen_justified = gen.right_justify("a", "bbb", "cc")
    assert_equal(test_justified, gen_justified)
  end

  def test_center_justify
    test_justified = ["  a  ", "bbbbb", " ccc ", " dd  "]
    gen = MarkMaker::Generator.new
    gen_justified = gen.center_justify("a", "bbbbb", "ccc", "dd")
    assert_equal(test_justified, gen_justified)
  end

  def test_column_width
    gen = MarkMaker::Generator.new
    width = gen.column_width("a", "bbb", "ccccc", "dd")
    assert_equal(5, width)
  end

  def test_centered_margins
    gen = MarkMaker::Generator.new
    left, right = gen.centered_margins(5, "cc")
    assert_equal(1, left)
    assert_equal(2, right)
  end

  # def test_right_justify_table_column
  #   right_justified = <<-EOS.strip_heredoc
  #     |Justified  |
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
  #   pretty_table = <<-EOS.strip_heredoc
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

