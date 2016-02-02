require 'simplecov'
SimpleCov.start

require 'minitest_helper'

class TestMarkMakerString < Minitest::Test
  def test_header1_generation
    title = "abc123"
    markup = title.header1
    assert_match(/^={#{title.size}}$/, markup)
    assert_match(/^#{title}$/, markup)
    assert_match(/^#{title}\n={#{title.size}}$/, markup)
  end

  def test_header2_generation
    title = "abc123"
    markup = title.header2
    assert_match(/^-{#{title.size}}$/, markup)
    assert_match(/^#{title}$/, markup)
    assert_match(/^#{title}\n-{#{title.size}}$/, markup)
  end

  def test_header3_generation
    title = "abc123"
    markup = title.header3
    assert_match(/###\s#{title}/, markup)
  end

  def test_bullet_generation
    content = "This is a bullet"
    markup = content.bullet
    assert_match(/^ - #{content}$/, markup)
  end

  def test_number_generation
    content = "Number this line"
    markup = content.number
    assert_match(/^\s\d\.\s#{content}$/, markup)
  end

  def test_code_generation
    content = "var = code()"
    markup = content.code
    assert_match(/\s{4}var = code\(\)$/, markup)
  end

  def test_code_span_generation
    markup = "Some #{'a = b + c'.code_span} here."
    assert_match(/^Some #{MarkMaker::CODE_TIC}a = b \+ c#{MarkMaker::CODE_TIC} here.$/, markup)
  end
end
