# frozen_string_literal: true

describe Interphase::Helpers::LayoutParser do
  it 'rejects non-rectangular input' do
    expect { described_class.new("aaa\nbb").parse }.to raise_error(RuntimeError)
  end

  it 'rejects non-rectangular widgets' do
    expect { described_class.new("aab\naaa").parse }.to \
      raise_error(RuntimeError)
  end

  context 'valid input' do
    let(:layout) { "aab\nccb" }

    it 'does not raise' do
      described_class.new(layout).parse
    end

    it 'creates a valid placement' do
      placement = described_class.new(layout).parse
      expect(placement.rows).to eq 2
      expect(placement.columns).to eq 3
      expect(placement.widgets.keys).to eq %w[a b c]
      expect(placement.widgets['a']).to be_a_placement_of 0, 2, 0, 1
      expect(placement.widgets['b']).to be_a_placement_of 2, 3, 0, 2
      expect(placement.widgets['c']).to be_a_placement_of 0, 2, 1, 2
    end
  end
end
