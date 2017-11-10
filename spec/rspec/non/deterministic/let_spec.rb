require "spec_helper"

RSpec.describe Rspec::Non::Deterministic::Let do
  it "has a version number" do
    expect(Rspec::Non::Deterministic::Let::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
