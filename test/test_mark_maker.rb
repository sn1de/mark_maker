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
end

