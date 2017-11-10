require "spec_helper"

RSpec.describe RSpec::NonDeterministicLet do
  it "has a version number" do
    expect(RSpec::NonDeterministicLet::VERSION).not_to be nil
  end

  context 'normal use' do
    nd_let_context 'test' do
      nd_let(:test) { 1 }
      nd_let(:test) { 2 }

      it 'test = 1 or 2' do
        expect(test).to gte 1
        expect(test).to lte 1
      end
    end
  end
end
