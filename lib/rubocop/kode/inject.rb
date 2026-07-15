# frozen_string_literal: true

module RuboCop
  module Kode
    module Inject
      def self.defaults!
        path = File.expand_path("../../../config/default.yml", __dir__)
        hash = RuboCop::ConfigLoader.load_yaml_configuration(path)

        resolver = RuboCop::ConfigLoaderResolver.new
        resolver.resolve_inheritance_from_gems(hash)
        resolver.resolve_inheritance(path, hash, path, RuboCop::ConfigLoader.debug?)
        hash.delete("inherit_from")

        config = RuboCop::Config.new(hash, path)
        puts "configuration from #{path}" if ENV["DEBUG"]
        config = RuboCop::ConfigLoader.merge_with_default(config, path)
        RuboCop::ConfigLoader.instance_variable_set(:@default_configuration, config)
      end
    end
  end
end
