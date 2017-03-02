$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mark_maker'
require 'mark_maker_string'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
