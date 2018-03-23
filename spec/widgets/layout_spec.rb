# frozen_string_literal: true

describe Interphase::Layout do
  let(:layout) { described_class.new("aaa\nbbb") }

  it 'throws on overwriting slots' do
    layout['a'] = Label.new('')
    expect { layout['a'] = Label.new('') }.to raise_error(RuntimeError)
  end
end
