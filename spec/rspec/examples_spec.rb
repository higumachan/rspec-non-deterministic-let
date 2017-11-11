require "spec_helper"

RSpec.describe 'Some test'do
  nd_let(:some_state) { 1 }
  nd_let(:some_state) { 2 }

  nd_let_context :some_state do
    it 'some_state = 1 or 2' do
      expect(some_state).to be >= 1
      expect(some_state).to be <= 2
    end
    it 'some_state only 1 or 2' do
      expect(some_state).not_to be < 1
      expect(some_state).not_to be > 2
    end
  end
end


RSpec.describe 'Some test without this gem'do

  shared_examples 'some_state is 1 or 2' do
    it 'some_state = 1 or 2' do
      expect(some_state).to be >= 1
      expect(some_state).to be <= 2
    end
    it 'some_state only 1 or 2' do
      expect(some_state).not_to be < 1
      expect(some_state).not_to be > 2
    end
  end

  context 'some_state = 1' do
    let(:some_state) { 1 }
    include_examples 'some_state is 1 or 2' 
  end

  context 'some_state = 2' do
    let(:some_state) { 1 }
    include_examples 'some_state is 1 or 2' 
  end
end

RSpec.describe 'Some test use by description' do
  nd_let(:some_state, 'some_state = 1') { 1 }
  nd_let(:some_state, 'some_state = 2') { 2 }

  nd_let_context :some_state do
    it 'some_state = 1 or 2' do
      expect(some_state).to be >= 1
      expect(some_state).to be <= 2
    end
    it 'some_state only 1 or 2' do
      expect(some_state).not_to be < 1
      expect(some_state).not_to be > 2
    end
  end
end

