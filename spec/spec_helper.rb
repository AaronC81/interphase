# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rspec'
require 'interphase'

RSpec.shared_examples 'a text container' do
  context 'text' do
    it 'is editable using #text=' do
      subject.text = 'foo'
      expect(subject.text).to eq('foo')
    end

    it 'is initialized to an empty string' do
      expect(subject.text).to eq('')
    end

    it 'is frozen' do
      expect { subject.text.reverse! }.to raise_error(RuntimeError)
    end
  end
end

RSpec::Matchers.define :be_a_placement_of do |left, right, top, bottom|
  match do |actual|
    actual.is_a?(Interphase::Helpers::LayoutPlacement) \
      && actual.left == left \
      && actual.right == right \
      && actual.top == top \
      && actual.bottom == bottom
  end
end

include Interphase
