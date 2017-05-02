require 'simplecov'
SimpleCov.start

require 'minitest_helper'

class TestMarkMakerString < Minitest::Test
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

  def test_emphasis_generation
    content = "emphasize this"
    markup = content.emphasis
    assert_match(/^#{Regexp.quote(MarkMaker::EMPHASIS)}#{content}#{Regexp.quote(MarkMaker::EMPHASIS)}$/, markup)
  end

  def test_strong_generation
    content = "strong stuff"
    markup = content.strong
    assert_match(/^#{Regexp.quote(MarkMaker::EMPHASIS * 2)}#{content}#{Regexp.quote(MarkMaker::EMPHASIS * 2)}$/, markup)
  end
end
