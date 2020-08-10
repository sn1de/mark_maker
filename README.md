![MarkMaker build status](https://travis-ci.org/sn1de/mark_maker.svg?branch=master "Build Status")

MarkMaker
=========

Programatically generate markdown documents.

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
currently supports headings, links, bullets, numbered
bullets, *emphasis*, **strong**, code
and table markdown. See bin/generate_readme.rb for the code used to generate this
document and a sample of all these markdown generators in action.

Simple markdown generation is handled by extensions to the ruby String class. Headers,
code, emphasis, and strong are all handled by String methods.

Multi line and more complex conversions are handled by a Generator class.

### Header Example

The following ruby code ...

```ruby
  h = "Let It Begin"
  puts h.header1
  puts h.header2
  puts h.header3
  puts h.header4
  puts h.header5
  puts h.header6
```

Results in this generated markdown ...
```
Let It Begin
============
Let It Begin
------------
### Let It Begin
#### Let It Begin
##### Let It Begin
###### Let It Begin
```

Ultimately looking something like this (if your are viewing this on github or through some other markdown viewing method) ...

Let It Begin
============
Let It Begin
------------
### Let It Begin
#### Let It Begin
##### Let It Begin
###### Let It Begin


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

```ruby
  header, separator = gen.table_header("Col One", "Col Two", "Col Three")
  puts header
  puts separator
  puts gen.table_row("First", "A", "$3.99")
  puts gen.table_row("Second", "BC", "$14.00")
  puts gen.table_row("Third", "DEFGH", "$1,034.50")
```

Produces this terribly ugly markdown (but standby, there is a better way below) ...

```
|Col One|Col Two|Col Three|
|-------|-------|---------|
|First|A|$3.99|
|Second|BC|$14.00|
|Third|DEFGH|$1,034.50|
```

Or, you can pass all the rows in at once like so ...

```ruby
  table_data = [
    ["Col One", "Col Two", "Col Three"],
    [":-", ":-:", "-:"],
    ["First", "A", "$3.99"],
    ["Second", "BC", "$14.00"],
    ["Third", "DEFGH", "$1,034.50"]
  ]
  puts gen.table(*table_data)
```
And get nicely justified markdown like this ...
```
|Col One|Col Two|Col Three|
|:------|:-----:|--------:|
|First  |   A   |    $3.99|
|Second |  BC   |   $14.00|
|Third  | DEFGH |$1,034.50|
```
Which gives you this stunning HTML table ...

|Col One|Col Two|Col Three|
|:------|:-----:|--------:|
|First  |   A   |    $3.99|
|Second |  BC   |   $14.00|
|Third  | DEFGH |$1,034.50|


### Block Quotes Example

```
content = <<-QUOTE
If you want to quote, you'll get a quote.
Warning, it will just quote line by line, not break it up nicely.
QUOTE
puts gen.block_quote(*content.lines)
```

Produces the markdown ...

```
> If you want to quote, you'll get a quote.
> Warning, it will just quote line by line, not break it up nicely.
```


Which looks like this when viewed as HTML...

> If you want to quote, you'll get a quote.
> Warning, it will just quote line by line, not break it up nicely.


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

Supported Ruby Versions
-----------------------

The following ruby versions are explicitly supported and exercised via TravisCI (see .travis.yml)

 - ruby-head
 - 2.7
 - 2.6
 - 2.3

Release Process
---------------

Document release changes in `CHANGELOG.md`

Increment the VERSION number in `lib/mark_maker/version.rb`

Run `rake release` which will:

 - build the gem into the `pkg/` director
 - create a git tag for the version
 - push to github
 - push the packaged gem to rubygems
