require "spec_helper"

RSpec.describe RSpec::NonDeterministicLet do
  it "has a version number" do
    expect(RSpec::NonDeterministicLet::VERSION).not_to be nil
  end

  context 'normal use' do
    nd_let(:nadeko) { 1 }
    nd_let(:nadeko) { 2 }

    nd_let_context :nadeko do
      it 'test = 1 or 2' do
        expect(nadeko).to be >= 1
        expect(nadeko).to be <= 2
      end
      it 'test only 1 or 2' do
        expect(nadeko).not_to be < 1
        expect(nadeko).not_to be > 2
      end
    end
  end

  context 'with description' do
    nd_let(:nadeko, 'nadeko = 1') { 1 }
    nd_let(:nadeko, 'nadeko = 2') { 2 }

    nd_let_context :nadeko do
      it 'test = 1 or 2' do
        expect(nadeko).to be >= 1
        expect(nadeko).to be <= 2
      end
      it 'test only 1 or 2' do
        expect(nadeko).not_to be < 1
        expect(nadeko).not_to be > 2
      end
    end
  end
end
