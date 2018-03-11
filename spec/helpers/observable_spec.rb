# frozen_string_literal: true

describe Interphase::Helpers::Observable do
  before(:all) do
    @block_triggered = false
  end

  let(:subject) do
    described_class.new(%w[a b c]) do
      @block_triggered = true
    end
  end

  context 'trigger' do
    it 'occurs when the object changes' do
      # A call which changes the block
      subject << 'd'

      expect(@block_triggered).to be true
    end

    it 'does not occur when the object does not change' do
      # A call which doesn't change the block
      subject.length

      expect(@block_triggered).to be false
    end
  end

  it 'implements #respond_to?' do
    expect(subject.respond_to?(:length)).to be true
    expect(subject.respond_to?(:not_a_method)).to be false
  end
end
