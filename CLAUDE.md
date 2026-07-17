# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run all tests
bundle exec rake test

# Run a single test file
bundle exec ruby -Ilib -Itest test/test_mark_maker.rb

# Run a single test by name
bundle exec ruby -Ilib -Itest test/test_mark_maker.rb -n test_pretty_table_generation

# Run linter (RuboCop on lib/)
bundle exec rake rubocop

# Regenerate README.md
bundle exec rake readme

# Open interactive console
bundle exec rake console
```

## Architecture

This is a Ruby gem with two main components:

1. **String extensions** (`lib/mark_maker_string.rb`) — Adds markdown conversion methods directly to Ruby's `String` class: `header1`–`header6`, `bullet`, `number`, `code`, `code_span`, `emphasis`, `strong`.

2. **Generator class** (`lib/mark_maker/generator.rb`) — Handles multi-line and complex conversions: `bullets`, `numbers`, `link`, `image`, `code_block`, `fenced_code_block`, `fenced_code_language`, `table_header`, `table_row`, `table`, `block_quote`, and the justify family of methods.

The `table` method is the most complex: it transposes input rows into columns, applies per-column justification based on a justification indicator row (position 2 in each column), then transposes back. Justification indicators follow GitHub Flavored Markdown syntax (`:-` left, `-:` right, `:-:` center) and must be filled with `-` chars (not spaces) so GFM renders them correctly.

`bin/generate_readme.rb` is the canonical usage example — it generates `README.md` via `rake readme`.

## Testing

Uses Minitest with simplecov for coverage. Tests live in `test/` alongside `minitest_helper.rb` which sets up the load path.
