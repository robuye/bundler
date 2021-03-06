# frozen_string_literal: true

RSpec.describe "bundle command names" do
  it "work when given fully" do
    ensure_no_gemfile
    bundle "install"
    expect(err).to eq("Could not locate Gemfile")
    expect(last_command.stdboth).not_to include("Ambiguous command")
  end

  it "work when not ambiguous" do
    ensure_no_gemfile
    bundle "ins"
    expect(err).to eq("Could not locate Gemfile")
    expect(last_command.stdboth).not_to include("Ambiguous command")
  end

  it "print a friendly error when ambiguous" do
    bundle "in"
    expect(err).to eq("Ambiguous command in matches [info, init, inject, install]")
  end

  context "when cache_command_is_package is set" do
    before { bundle! "config set cache_command_is_package true" }

    it "dispatches `bundle cache` to the package command" do
      bundle "cache --verbose"
      expect(out).to start_with "Running `bundle package --verbose`"
    end
  end
end
