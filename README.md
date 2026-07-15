# rubocop-kode

Custom RuboCop cops, department `Kode`.

## Install

```ruby
# Gemfile
gem "rubocop-kode", require: false
```

Or straight from GitHub while it's not yet published to RubyGems:

```ruby
gem "rubocop-kode", git: "https://github.com/Dach3r/rubocop-kode", require: false
```

## Usage

```yaml
# .rubocop.yml
require:
  - rubocop-kode
```

## Cops

- `Kode/NoArgumentAlignment` — one space after commas between call arguments.
- `Kode/NoHashAlignment` — one space after `=>` or `:` in hash pairs.
- `Kode/NoAssignmentAlignment` — one space before `=` in assignments and setters.

All prevent column-alignment via extra spaces and are auto-correctable.

Indentation of methods after `private`/`protected` (flush vs. indented) is
already covered by core RuboCop's `Layout/IndentationWidth` and
`Layout/IndentationConsistency` (`EnforcedStyle: indented_internal_methods`)
— no custom cop needed for that.

## Development

```
bundle install
bundle exec rspec
```
