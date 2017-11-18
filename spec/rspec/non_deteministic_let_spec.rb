require "spec_helper"

RSpec.describe RSpec::NonDeterministicLet do
  it "has a version number" do
    expect(RSpec::NonDeterministicLet::VERSION).not_to be nil
  end

  context 'normal use' do
    nd_let(:nadeko) { 1 }
    nd_let(:nadeko) { 2 }

    nd_let_context :nadeko do
      it 'nadeko = 1 or 2' do
        expect(nadeko).to be >= 1
        expect(nadeko).to be <= 2
      end
      it 'nadeko only 1 or 2' do
        expect(nadeko).not_to be < 1
        expect(nadeko).not_to be > 2
      end
    end
  end

  context 'with description' do
    nd_let(:nadeko, 'nadeko = 1') { 1 }
    nd_let(:nadeko, 'nadeko = 2') { 2 }

    nd_let_context :nadeko do
      it 'nadeko = 1 or 2' do
        expect(nadeko).to be >= 1
        expect(nadeko).to be <= 2
      end
      it 'nadeko only 1 or 2' do
        expect(nadeko).not_to be < 1
        expect(nadeko).not_to be > 2
      end
    end
  end

  context 'stateful block' do
    context 'with nd_let!' do
      nd_let!(:nadeko) do 
        @rikka = 100
        1 
      end
      nd_let!(:nadeko) do 
        @rikka = 101
        2
      end
      nd_let_context :nadeko do
        it 'nadeko = 1 or 2' do
          expect(nadeko).to be >= 1
          expect(nadeko).to be <= 2
        end
        it 'nadeko only 1 or 2' do
          expect(nadeko).not_to be < 1
          expect(nadeko).not_to be > 2
        end
        it '@rikka = 100 or 101' do
          expect(@rikka).to be >= 100
          expect(@rikka).to be <= 101
        end
        it '@rikka only 100 or 101' do
          expect(@rikka).not_to be < 100
          expect(@rikka).not_to be > 101
        end
      end
    end
    context 'with nd_let' do
      before do
        @rikka = nil
      end
      nd_let(:nadeko) do 
        @rikka = 100
        1 
      end
      nd_let(:nadeko) do 
        @rikka = 101
        2
      end
      nd_let_context :nadeko do
        it 'nadeko = 1 or 2' do
          expect(nadeko).to be >= 1
          expect(nadeko).to be <= 2
        end
        it 'nadeko only 1 or 2' do
          expect(nadeko).not_to be < 1
          expect(nadeko).not_to be > 2
        end
        it '@rikka be nil' do
          expect(@rikka).to be_nil
        end

        it '@rikka = 100 or 101 when after access nadeko' do
          nadeko
          expect(@rikka).to be >= 100
          expect(@rikka).to be <= 101
        end
      end
    end
  end

  context 'multi variable nd_let_context' do
    nd_let(:nadeko, 'nadeko = 1') { 1 }
    nd_let(:nadeko, 'nadeko = 2') { 2 }
    nd_let(:rikka, 'rikka = 3') { 3 }
    nd_let(:rikka, 'rikka = 4') { 4 }

    nd_let_context :nadeko, :rikka do
      it 'nadeko = 1 or 2' do
        expect(nadeko).to be >= 1
        expect(nadeko).to be <= 2
      end
      it 'nadeko only 1 or 2' do
        expect(nadeko).not_to be < 1
        expect(nadeko).not_to be > 2
      end

      it 'rikka = 3 or 4' do
        expect(rikka).to be >= 3
        expect(rikka).to be <= 4
      end
      it 'rikka only 1 or 2' do
        expect(rikka).not_to be < 3
        expect(rikka).not_to be > 4
      end
    end
  end
end
