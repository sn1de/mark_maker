$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mark_maker'
require 'active_support/core_ext/string'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
