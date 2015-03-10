require "mark_maker/version"
require "mark_maker/generator"

begin
  require "pry"
rescue LoadError
end

# MarkMaker is a markdown generation capability. It is intended to be
# very straightforward, non-tricky and easy to expand upon going
# forward. The intended use case is taking data from one structured
# format and generating markdown documents from that source in
# a line by line method.
module MarkMaker
end
