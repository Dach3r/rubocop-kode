# frozen_string_literal: true

require_relative "lib/rubocop/kode/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-kode"
  spec.version = RuboCop::Kode::VERSION
  spec.authors = ["David Noreña"]
  spec.summary = "Custom RuboCop cops for kode house style."
  spec.description = "A collection of custom RuboCop cops (Kode department) enforcing spacing and alignment rules not covered by stock RuboCop."
  spec.homepage = "https://github.com/Dach3r/rubocop-kode"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*.rb", "config/*.yml", "LICENSE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", ">= 1.72", "< 2.0"
  spec.add_dependency "rubocop-ast", ">= 1.38.0", "< 2.0"
end
