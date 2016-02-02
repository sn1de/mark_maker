require 'simplecov'
SimpleCov.start

require 'minitest_helper'

class TestMarkMakerString < Minitest::Test
  def test_header1_generation_string
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
end
