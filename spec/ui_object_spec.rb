# frozen_string_literal: true

describe Interphase::UiObject do
  let(:subject) { UiObject.new(Gtk::Label.new) }

  it 'exposes its wrapped instance' do
    expect(subject.gtk_instance.is_a?(Gtk::Object)).to be true
    expect { subject.gtk_instance = Gtk::Label.new }.to \
      raise_error(NoMethodError)
  end

  it 'can be destroyed' do
    subject.destroy
    expect(subject.destroyed?).to be true
  end
end
