# Extreme Readme Driven Development
#
# Readme Driven Development Explained:
# http://tom.preston-werner.com/2010/08/23/readme-driven-development.html?utm_source=build-a-ruby-gem&utm_medium=ebook&utm_campaign=structure
#
# It occured to me as I was going through the act of turning 
# this set of code used to generate markdown into a gem, that 
# using the code to generate the readme programatically 
# would be a good way to eat my own dogfood and provide
# a definitive and prominent set of capabilities and 
# examples. So here goes ... extreme readme driven development!
# (it's kind of like Inception)

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
doc << "TODO: Write usage instructions here ... ideally embed the code used to create the readme!"
doc << ""
doc << gen.header2("Contributing")
doc << ""
doc << gen.number("Fork it ( https://github.com/[my-github-username]/mark_maker/fork )")
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
puts doc