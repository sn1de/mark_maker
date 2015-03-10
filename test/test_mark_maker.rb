require 'minitest_helper'

class TestMarkMaker < MiniTest::Unit::TestCase

  def test_that_it_has_a_version_number
    refute_nil ::MarkMaker::VERSION
  end

  def test_header1_generation
    title = "abc123"
    markup = MarkMaker.header1(title)
    assert_match(/^={#{title.size}}$/, markup)
    assert_match(/^#{title}$/, markup)
    assert_match(/^#{title}\n={#{title.size}}$/, markup)
  end

  def test_header2_generation
    title = "abc123"
    markup = MarkMaker.header2(title)
    assert_match(/^-{#{title.size}}$/, markup)
    assert_match(/^#{title}$/, markup)
    assert_match(/^#{title}\n-{#{title.size}}$/, markup)
  end

  def test_bullet_generation
    content = "This is a bullet"
    markup = MarkMaker.bullet(content)
    assert_match(/^ - #{content}$/, markup)
  end

  def test_link_generation
    label = "anywhere"
    url = "http://www.yahoo.com"
    markup = MarkMaker.link(label, url)
    assert_match(/^\[#{label}\]\(#{url}\)$/, markup)
  end

end
