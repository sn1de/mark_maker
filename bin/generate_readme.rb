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
# examples. So here goes ... extreme readme driven development!

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
puts gen.header1("MarkMaker")
puts ""
puts "Programatically generate markdown documents."
puts ""
puts gen.header1("Intended Use")
puts ""
puts "The mark_maker gem provides a set of methods that take text content and"
puts "convert it to various markdown elements. The primary use case is simple"
puts "conversion of something like a JSON document into a markdown document."
puts "" 
puts "The initial development goal is to provide"
puts "support for all of the markdown supported operations, at least in their basic form. What"
puts "I mean by basic is that you provide a 'chunk' of content and the mark_maker #{gen.code_span('Generator')}"
puts "will return that content in the corresponding markdown format. For grouped content, variable"
puts "parameters will be provided on the method call to allow for things like correctly numbered"
puts "bullet lists. But other than that each call to the generator is treated as a separate"
puts "markdown operation. So things like link definitions aren't going to be supported in 1.0"
puts ""
puts "Speaking of versioning, I'll use semantic versioning to indicate when new markdown"
puts "capabilities are added. I'll release 1.0 when I feel like it supports a complete set"
puts "of markdown capabilites withing the constraint set above. This will also include some"
puts "extended capabilities from expanded syntaxes like GitHub flavored markdown. Methods"
puts "generating non-core markdown will be noted in the documentation for that method."
puts ""
puts "If all goes well, and it appears anyone is using this gem, then a 2.0 release is"
puts "envisioned that will add a #{ gen.code('Document') } class that will provide a"
puts "more holistic layer of capabilities. For example, the aformentioned reference style"
puts "links would be nice. As would the ability to have an arbitrarily long string broken"
puts "down into nicely formatted hard break paragraphs. Same goes for nicely indented multi-line"
puts "bullets, etc."
puts ""
puts gen.header2("Installation")
puts ""
puts "Add this line to your application's Gemfile:"
puts ""
puts gen.code("gem 'mark_maker'")
puts ""
puts "And then execute:"
puts ""
puts gen.code("$ bundle")
puts ""
puts "Or install it yourself as:"
puts ""
puts gen.code("$ gem install mark_maker")
puts ""
puts gen.header2("Usage")
puts ""
puts "MarkMaker provides line oriented conversion of content to markdown elements. It"
puts "currently supports first, second and third level headings, links, bullets, numbered"
puts "bullets, #{gen.emphasis('emphasis')}, #{gen.strong('strong')}, code"
puts "and basic table markdown. See #{__FILE__} for the code used to generate this"
puts "document and a sample of all these markdown generators in action."
puts ""
puts gen.header3("Header Example")
example_header = "Let It Begin"
puts gen.code("gen = MarkMaker::Generator.new")
puts gen.code("gen.header1('#{example_header}'')")
puts "\nProduces\n\n"
gen.header1(example_header).lines.map { |l| puts gen.code(l) }
puts ""
puts gen.header3("Bulleted List Example")
list_content = ['gold', 'silver', 'bronze']
puts ""
puts gen.code("list_content = ['gold', 'silver', 'bronze']")
puts gen.code("gen.bullets(*list_content)")
puts "\nProduces\n\n"
puts gen.code_block(*gen.bullets(*list_content))
puts ""
puts "Or a numbered list with..."
puts ""
numbered_code = "gen.numbers(*list_content)"
puts gen.code(numbered_code)
puts ""
puts "Produces"
puts ""
puts gen.code_block(*eval(numbered_code))
puts ""
puts gen.header3("Code Examples")
puts ""
puts "Standard markdown code blocks and #{gen.code_span('code span')} are supported, as well as github"
puts "flavored markdown fenced code blocks."
puts ""
sample_block = <<-EOT.split("\n")
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
puts gen.code(fenced_code)
puts ""
puts "Produces"
puts ""
puts gen.code_block(*eval("#{sample_block.join}\n#{fenced_code}\n"))
puts ""
puts "You can also include a language in a fenced code block."
puts ""
fenced_code_language = "gen.fenced_code_language('ruby', *some_code)"
puts gen.code(fenced_code_language)
puts ""
puts "Produces"
puts ""
puts gen.code_block(*eval("#{sample_block.join}\n#{fenced_code_language}"))
puts ""
puts "Rendering beautifully highlighted code like so, if you are viewing this on github."
puts ""
puts eval("#{sample_block.join}\n#{fenced_code_language}")
puts ""
puts gen.header3("Table Example")
puts ""
table_code = <<-EOT
  header, separator = gen.table_header("Col One", "Col Two", "Col Three")
  puts header
  puts separator
  puts gen.table_row("First", "A", "$3.99")
  puts gen.table_row("Second", "B", "$14.00")
  puts gen.table_row("Third", "C", "$1,034.50")
EOT
puts gen.code_block(*table_code.split("\n"))
puts ""
puts "Produces this terribly ugly markdown ..."
puts ""
table_markdown = capture_stdout do 
  eval(table_code)
end
puts gen.fenced_code_block(*table_markdown.string.split("\n"))
puts ""
puts "Which gives you this stunning HTML table ..."
puts ""
puts eval(table_code)
puts ""
puts gen.header2("Contributing")
puts ""
puts gen.numbers(gen.link("Fork it", "https://github.com/sn1de/mark_maker/fork"),
                   "Create your feature branch (`git checkout -b my-new-feature`)",
                   "Commit your changes (`git commit -am 'Add some feature'`)",
                   "Push to the branch (`git push origin my-new-feature`)",
                   "Create a new Pull Request")
puts ""
puts gen.header2("About This README")
puts ""
puts "This readme document is created using MarkMaker. To modify it, edit the code"
puts "in #{__FILE__} and then run the 'readme' rake task to generate and overwrite the"
puts "existing README.md"
puts ""
puts gen.code("vi #{__FILE__}")
puts gen.code("rake readme")
puts ""
puts "I'm calling this Extreme #{gen.link("Readme Driven Development", "http://tom.preston-werner.com/2010/08/23/readme-driven-development.html")}."
puts "It's kind of like #{gen.link("Inception", "http://en.wikipedia.org/wiki/Inception")} ;)"
