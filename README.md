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
currently supports first, second and third level headings, links, bullets, numbered
bullets and code markdown. See bin/generate_readme.rb for the code used to generate this
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

 1. gold
 2. silver
 3. bronze

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
