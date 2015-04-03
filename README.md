MarkMaker
=========

Programatically generate markdown documents.

Intended Use
------------

The mark_maker gem provides a set of methods that take text content and
convert it to various markdown elements. The primary use case is simple
conversion of something like a JSON document into a markdown document.

The initial development goal is to provide
support for all of the markdown supported operations, at least in their basic form. What
I mean by basic is that you provide a 'chunk' of content and the mark_maker `Generator`
will return that content in the corresponding markdown format. For grouped content, variable
parameters will be provided on the method call to allow for things like correctly numbered
bullet lists. Each call to the generator is treated as a separate
markdown operation. So things like link definitions aren't going to be supported,
at least not in 1.0

Speaking of versioning, I'll use semantic versioning to indicate when new markdown
capabilities are added. I'll release 1.0 when I feel like it supports set
of markdown capabilites that fulfill the intended use. This will also include some
extended capabilities from expanded syntaxes like GitHub flavored markdown. Methods
generating non-core markdown will be noted in the documentation for that method.

If all goes well, and it appears anyone is using this gem, then a 2.0 release is
envisioned that will add a `Document` class that will provide a
more holistic layer of capabilities. For example, the aformentioned reference style
links would be nice. As would the ability to have an arbitrarily long string broken
down into nicely formatted hard break paragraphs. Same goes for nicely indented multi-line
bullets, etc.

Installation
------------

Add this line to your application's Gemfile:

    gem 'mark_maker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mark_maker

Usage
-----

MarkMaker provides line oriented conversion of content to markdown elements. It
currently supports first, second and third level headings, links, bullets, numbered
bullets, *emphasis*, **strong**, code
and basic table markdown. See bin/generate_readme.rb for the code used to generate this
document and a sample of all these markdown generators in action.

### Header Example
    gen = MarkMaker::Generator.new
    gen.header1('Let It Begin'')

Produces

    Let It Begin
    ============

### Bulleted List Example

    list_content = ['gold', 'silver', 'bronze']
    gen.bullets(*list_content)

Produces

     - gold
     - silver
     - bronze

Or a numbered list with...

    gen.numbers(*list_content)

Produces

     1. gold
     2. silver
     3. bronze

### Code Examples

Standard markdown code blocks and `code span` are supported, as well as github
flavored markdown fenced code blocks.

    some_code = [ "# add it up",
                  "total = [1, 2, 3, 4].inject do |sum, i|",
                  "  sum += i",
                  "end",
                  "",
                  "puts total" ]
    gen.code_block(*some_code)

Produces

        # add it up
        total = [1, 2, 3, 4].inject do |sum, i|
          sum += i
        end
        
        puts total

You can also generate a github flavored markdown fenced code version.

    gen.fenced_code_block(*some_code)

Produces

    ```
    # add it up
    total = [1, 2, 3, 4].inject do |sum, i|
      sum += i
    end
    
    puts total
    ```

You can also include a language in a fenced code block.

    gen.fenced_code_language('ruby', *some_code)

Produces

    ```ruby
    # add it up
    total = [1, 2, 3, 4].inject do |sum, i|
      sum += i
    end
    
    puts total
    ```

Rendering beautifully highlighted code like so, if you are viewing this on github.

```ruby
# add it up
total = [1, 2, 3, 4].inject do |sum, i|
  sum += i
end

puts total
```

### Table Example

      header, separator = gen.table_header("Col One", "Col Two", "Col Three")
      puts header
      puts separator
      puts gen.table_row("First", "A", "$3.99")
      puts gen.table_row("Second", "B", "$14.00")
      puts gen.table_row("Third", "C", "$1,034.50")

Produces this terribly ugly markdown ...

```
|Col One|Col Two|Col Three|
|-------|-------|---------|
|First|A|$3.99|
|Second|B|$14.00|
|Third|C|$1,034.50|
```

Which gives you this stunning HTML table ...

|Col One|Col Two|Col Three|
|-------|-------|---------|
|First|A|$3.99|
|Second|B|$14.00|
|Third|C|$1,034.50|


Contributing
------------

 1. [Fork it](https://github.com/sn1de/mark_maker/fork)
 2. Create your feature branch (`git checkout -b my-new-feature`)
 3. Commit your changes (`git commit -am 'Add some feature'`)
 4. Push to the branch (`git push origin my-new-feature`)
 5. Create a new Pull Request

About This README
-----------------

This readme document is created using MarkMaker. To modify it, edit the code
in bin/generate_readme.rb and then run the 'readme' rake task to generate and overwrite the
existing README.md

    vi bin/generate_readme.rb
    rake readme

I'm calling this Extreme [Readme Driven Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html).
It's kind of like [Inception](http://en.wikipedia.org/wiki/Inception) ;)
