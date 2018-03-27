# frozen_string_literal: true

describe Interphase::Window do
  let(:subject) { described_class.new('Window') }

  it 'supports background threads' do
    thread_done = false
    new_thread = subject.in_background { thread_done = true }

    new_thread.join
    expect(thread_done).to be true
  end

  it 'kills threads on quit' do
    allow(Gtk).to receive(:main_quit) {}

    new_thread = subject.in_background { loop {} }

    subject.quit

    expect(new_thread.alive?).to be false
  end
end
