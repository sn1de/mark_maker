require 'simplecov'
SimpleCov.start

require 'minitest_helper'

class TestHeaders < Minitest::Test
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

  def test_header4_generation
    title = "abc123"
    markup = title.header4
    assert_match(/####\s#{title}/, markup)
  end

  def test_header5_generation
    title = "abc123"
    markup = title.header5
    assert_match(/#####\s#{title}/, markup)
  end

  def test_header6_generation
    title = "abc123"
    markup = title.header6
    assert_match(/######\s#{title}/, markup)
  end

  def test_invalid_header_level
    title = "abc123"
    assert_raises(ArgumentError) { title.header(7) }
  end

end
