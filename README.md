# rubocop-kode

House RuboCop config in a single dependency: bundles
[rubocop-rails-omakase](https://github.com/rails/rubocop-rails-omakase) as a
base style, adds a few extra house rules on top of it, and layers custom
cops (`Kode` department). No need to also depend on `rubocop-rails-omakase`
or repeat its config — this gem pulls it in transitively and inherits it.

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

That's it — no `inherit_gem` needed, this gem already inherits
`rubocop-rails-omakase`'s `rubocop.yml` and layers the house rules and
`Kode/*` cops on top. Add project-specific overrides below the `require` key
as usual.

## What's included on top of Omakase

- `Style/EndlessMethod` — disallowed
- `Style/SymbolArray` — percent style
- `Bundler/OrderedGems` — enabled
- `Layout/SpaceInsidePercentLiteralDelimiters` — enabled
- `Layout/ExtraSpacing` — `AllowForAlignment: false`
- `Layout/DefEndAlignment` — aligned with `start_of_line`
- `Layout/IndentationWidth` / `Layout/IndentationConsistency` — enabled
  (Omakase ships these disabled; enabling them enforces its
  `indented_internal_methods` style: methods after a bare access modifier
  get one extra indent level)

## Cops

- `Kode/NoArgumentAlignment` — one space after commas between call arguments.
- `Kode/NoHashAlignment` — one space after `=>` or `:` in hash pairs.
- `Kode/NoAssignmentAlignment` — one space before `=` in assignments and setters.

All prevent column-alignment via extra spaces and are auto-correctable.

## Development

```
bundle install
bundle exec rspec
```
