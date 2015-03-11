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
doc = []
gen = MarkMaker::Generator.new
doc << gen.header1("MarkMaker")
doc << ""
doc << "Programatically generate markdown documents."
doc << ""
doc << gen.header2("Installation")
doc << ""
doc << "Add this line to your application's Gemfile:"
doc << ""

# ```ruby

doc << gen.code("gem 'mark_maker'")

# ```

doc << ""
doc << "And then execute:"
doc << ""
doc << gen.code("$ bundle")
doc << ""
doc << "Or install it yourself as:"
doc << ""
doc << gen.code("$ gem install mark_maker")
doc << ""
doc << gen.header2("Usage")
doc << ""
doc << "MarkMaker provides line oriented conversion of content to markdown elements. It"
doc << "currently supports first, second and third level headings, links, bullets, numbered"
doc << "bullets and code markdown. See #{__FILE__} for the code used to generate this"
doc << "document and a sample of all these markdown generators in action."
doc << ""
doc << gen.header3("Header Example")
example_header = "Let It Begin"
doc << gen.code("gen = MarkMaker::Generator.new")
doc << gen.code("gen.header1('#{example_header}'')")
doc << "\nProduces\n\n"
gen.header1(example_header).lines.map { |l| doc << gen.code(l) }
doc << ""
doc << gen.header2("Contributing")
doc << ""
doc << gen.number(gen.link("Fork it", "https://github.com/sn1de/mark_maker/fork"))
doc << gen.number("Create your feature branch (`git checkout -b my-new-feature`)")
doc << gen.number("Commit your changes (`git commit -am 'Add some feature'`)")
doc << gen.number("Push to the branch (`git push origin my-new-feature`)")
doc << gen.number("Create a new Pull Request")
doc << ""
doc << gen.header2("About this README")
doc << ""
doc << "This readme document is created using MarkMaker. To modify it, edit the code"
doc << "in #{__FILE__} and then run the 'readme' rake task to generate and overwrite the"
doc << "existing README.md"
doc << ""
doc << gen.code("vi #{__FILE__}")
doc << gen.code("rake readme")
doc << ""
doc << "I'm calling this Extreme #{gen.link("Readme Driven Development", "http://tom.preston-werner.com/2010/08/23/readme-driven-development.html")}."
doc << "It's kind of like #{gen.link("Inception", "http://en.wikipedia.org/wiki/Inception")} ;)"
puts doc