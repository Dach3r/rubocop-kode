# frozen_string_literal: true

require_relative "kode/version"
require_relative "kode/inject"

Dir[File.join(__dir__, "cop/kode/**/*.rb")].sort.each { |file| require file }
