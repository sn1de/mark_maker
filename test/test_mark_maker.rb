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

  def test_number_generation
    content = "Number this line"
    gen = MarkMaker::Generator.new
    markup = gen.number(content)
    assert_match(/^\s\d\.\s#{content}$/, markup)
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
end
