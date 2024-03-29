#!/usr/bin/env ruby

# Extreme Readme Driven Development
#
# Readme Driven Development Explained:
# http://tom.preston-werner.com/2010/08/23/readme-driven-development.html?utm_source=build-a-ruby-gem&utm_medium=ebook&utm_campaign=structure
#
# It occured to me as I was going through the act of turning 
# this code library into a gem, that 
# using the code to generate the readme programatically 
# would be a good way to eat my own dogfood and provide
# a solid example.
# 
# So here goes ... extreme readme driven development!

require 'mark_maker'

def capture_stdout
  out = StringIO.new
  $stdout = out
  yield
  return out
ensure
  $stdout = STDOUT
end

gen = MarkMaker::Generator.new
puts gen.image("MarkMaker build status", "https://travis-ci.org/sn1de/mark_maker.svg?branch=master", "Build Status")
puts ""
puts "MarkMaker".header1
puts ""
puts "Programatically generate markdown documents."
puts ""
puts "Installation".header2
puts ""
puts "Add this line to your application's Gemfile:"
puts ""
puts "gem 'mark_maker'".code
puts ""
puts "And then execute:"
puts ""
puts "$ bundle".code
puts ""
puts "Or install it yourself as:"
puts ""
puts "$ gem install mark_maker".code
puts ""
puts "Usage".header2
puts ""
puts "MarkMaker provides line oriented conversion of content to markdown elements. It"
puts "currently supports headings, links, bullets, numbered"
puts "bullets, #{'emphasis'.emphasis}, #{'strong'.strong}, code"
puts "and table markdown. See #{__FILE__} for the code used to generate this"
puts "document and a sample of all these markdown generators in action."
puts ""
puts "Simple markdown generation is handled by extensions to the ruby String class. Headers,"
puts "code, emphasis, and strong are all handled by String methods."
puts ""
puts "Multi line and more complex conversions are handled by a Generator class."
puts ""
puts "Header Example".header3
puts ""
puts "The following ruby code ..."
puts ""
header_code = <<-EOT
  h = "Let It Begin"
  puts h.header1
  puts h.header2
  puts h.header3
  puts h.header4
  puts h.header5
  puts h.header6
EOT
puts gen.fenced_code_language('ruby', *header_code.lines)
puts ""
puts "Results in this generated markdown ..."
header_markdown = capture_stdout do
  eval(header_code)
end
puts gen.fenced_code_block(*header_markdown.string.lines)
puts "\nUltimately looking something like this (if your are viewing this on github or through some other markdown viewing method) ...\n\n"
puts eval(header_code)
puts ""
puts "Bulleted List Example".header3
list_content = ['gold', 'silver', 'bronze']
puts ""
puts "list_content = ['gold', 'silver', 'bronze']".code
puts "gen.bullets(*list_content)".code
puts "\nProduces\n\n"
puts gen.code_block(*gen.bullets(*list_content))
puts ""
puts "Or a numbered list with..."
puts ""
numbered_code = "gen.numbers(*list_content)"
puts numbered_code.code
puts ""
puts "Produces"
puts ""
puts gen.code_block(*eval(numbered_code))
puts ""
puts "Code Examples".header3
puts ""
puts "Standard markdown code blocks and #{'code span'.code_span} are supported, as well as github"
puts "flavored markdown fenced code blocks."
puts ""
sample_block = <<-EOT.lines.to_a
some_code = [ "# add it up",
              "total = [1, 2, 3, 4].inject do |sum, i|",
              "  sum += i",
              "end",
              "",
              "puts total" ]
EOT
execution_block = "gen.code_block(*some_code)"
puts gen.code_block(*sample_block, execution_block)
puts ""
puts "Produces\n\n"
puts gen.code_block(*gen.code_block(*eval(sample_block.join)))
puts ""
puts "You can also generate a github flavored markdown fenced code version."
fenced_code = "gen.fenced_code_block(*some_code)"
puts ""
puts fenced_code.code
puts ""
puts "Produces"
puts ""
puts gen.code_block(*eval("#{sample_block.join}\n#{fenced_code}\n"))
puts ""
puts "You can also include a language in a fenced code block."
puts ""
fenced_code_language = "gen.fenced_code_language('ruby', *some_code)"
puts fenced_code_language.code
puts ""
puts "Produces"
puts ""
puts gen.code_block(*eval("#{sample_block.join}\n#{fenced_code_language}"))
puts ""
puts "Rendering beautifully highlighted code like so, if you are viewing this on github."
puts ""
puts eval("#{sample_block.join}\n#{fenced_code_language}")
puts ""
puts "Table Example".header3
puts ""
table_code = <<-EOT
  header, separator = gen.table_header("Col One", "Col Two", "Col Three")
  puts header
  puts separator
  puts gen.table_row("First", "A", "$3.99")
  puts gen.table_row("Second", "BC", "$14.00")
  puts gen.table_row("Third", "DEFGH", "$1,034.50")
EOT
puts gen.fenced_code_language('ruby', *table_code.lines)
puts ""
puts "Produces this terribly ugly markdown (but standby, there is a better way below) ..."
puts ""
table_markdown = capture_stdout do 
  eval(table_code)
end
puts gen.fenced_code_block(*table_markdown.string.lines)
puts ""
puts "Or, you can pass all the rows in at once like so ..."
puts ""
pretty_table_code = <<-EOT
  table_data = [
    ["Col One", "Col Two", "Col Three"],
    [":-", ":-:", "-:"],
    ["First", "A", "$3.99"],
    ["Second", "BC", "$14.00"],
    ["Third", "DEFGH", "$1,034.50"]
  ]
  puts gen.table(*table_data)
EOT
puts gen.fenced_code_language('ruby', *pretty_table_code.lines)
puts "And get nicely justified markdown like this ..."
pretty_table_markdown = capture_stdout do
  eval(pretty_table_code)
end
puts gen.fenced_code_block(*pretty_table_markdown.string.lines)
puts "Which gives you this stunning HTML table ..."
puts ""
puts eval(pretty_table_code)
puts ""
puts "Block Quotes Example".header3
puts ""
block_quote_code = <<-EOT
content = <<-QUOTE
If you want to quote, you'll get a quote.
Warning, it will just quote line by line, not break it up nicely.
QUOTE
puts gen.block_quote(*content.lines)
EOT
puts gen.fenced_code_block(*block_quote_code.lines)
puts ""
puts "Produces the markdown ..."
puts ""
block_quote_markdown = capture_stdout do
  eval(block_quote_code)
end
puts gen.fenced_code_block(*block_quote_markdown.string.lines)
puts ""
puts ""
puts "Which looks like this when viewed as HTML..."
puts ""
puts eval(block_quote_code)
puts ""
puts "Contributing".header2
puts ""
puts gen.numbers(gen.link("Fork it", "https://github.com/sn1de/mark_maker/fork"),
                   "Create your feature branch (`git checkout -b my-new-feature`)",
                   "Commit your changes (`git commit -am 'Add some feature'`)",
                   "Push to the branch (`git push origin my-new-feature`)",
                   "Create a new Pull Request")
puts ""
puts "About This README".header2
puts ""
puts "This readme document is created using MarkMaker. To modify it, edit the code"
puts "in #{__FILE__} and then run the 'readme' rake task to generate and overwrite the"
puts "existing README.md"
puts ""
puts "vi #{__FILE__}".code
puts "rake readme".code
puts ""
puts "I'm calling this Extreme #{gen.link("Readme Driven Development", "http://tom.preston-werner.com/2010/08/23/readme-driven-development.html")}."
puts "It's kind of like #{gen.link("Inception", "http://en.wikipedia.org/wiki/Inception")} ;)"
puts ""
puts "Supported Ruby Versions".header2
puts ""
puts "The following ruby versions are explicitly supported and exercised via TravisCI (see .travis.yml)"
puts ""
puts gen.bullets("ruby-head", "2.7", "3.2")
puts ""
puts "Release Process".header2
puts ""
puts "Document release changes in `CHANGELOG.md`"
puts ""
puts "Increment the VERSION number in `lib/mark_maker/version.rb`"
puts ""
puts "Run `rake release` which will:"
puts ""
puts gen.bullets("build the gem into the `pkg/` director",
                 "create a git tag for the version",
                 "push to github",
                 "push the packaged gem to rubygems")

