1.1.0
-----

 - added frozen_string_literal magic comment to all library files
 - freeze mutable regex constants (LEFT_JUSTIFY, RIGHT_JUSTIFY, CENTER_JUSTIFY)
 - update Rubocop directive from deprecated Lint/HandleExceptions to Lint/SuppressedException
 - add rubocop-minitest and rubocop-rake extensions
 - prefer string interpolation over concatenation throughout generator.rb
 - rename short variable names to descriptive alternatives
 - fix fill_justify to avoid mutating frozen strings
 - consolidate SimpleCov.start to minitest_helper.rb only
 - remove commented-out dead code from generator.rb and test files

1.0.0
-----

 - just tidied up the README
 - clarified the supported ruby versions (all now 2.x variations)

0.9.0
-----

 - addressing security vulnerability associated with rake
 - dropping support for ruby 1.x versions
 - now calls for bundler 2

0.8.0
-----
 - added header 4 thru 6 support
 - fixed a bug in the image generation when using a title
 - noted supported ruby versions in the readme, per travis config

0.7.0
-----
 - added support for images
 - now support ruby 1.9.3, 2.2.4 and 2.3.0

0.3.0
-----

 - added very basic table support
