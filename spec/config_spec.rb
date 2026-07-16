# frozen_string_literal: true

RSpec.describe "default configuration" do
  let(:cop_config) { RuboCop::ConfigLoader.default_configuration.for_cop("Style/SingleLineMethods") }

  it "enables Style/SingleLineMethods" do
    expect(cop_config["Enabled"]).to be(true)
  end

  it "flags empty single-line method definitions" do
    expect(cop_config["AllowIfMethodIsEmpty"]).to be(false)
  end
end
