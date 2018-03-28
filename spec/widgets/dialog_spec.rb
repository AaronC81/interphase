# frozen_string_literal: true

describe Interphase::Dialog do
  let(:subject) { described_class.new }

  context 'given a button action' do
    it 'implements #action_to_integer' do
      expect(subject.action_to_integer(:accept)).to eq \
        Gtk::Dialog::RESPONSE_ACCEPT
      expect(subject.action_to_integer(:delete)).to eq \
        Gtk::Dialog::RESPONSE_DELETE_EVENT
    end

    it 'can add a new button' do
      subject.add_button('OK', :accept)
      subject.add_button('Cancel', :delete)
    end
  end
end
