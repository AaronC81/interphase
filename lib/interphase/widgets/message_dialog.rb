# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A message dialog which displays text and some buttons.
  class MessageDialog < Dialog
    # Create a new message dialog.
    # +message+:: The message which the dialog displays.
    def initialize(message, **options, &block)
      super(
        Gtk::MessageDialog.new(
          nil,
          0,
          Gtk::MessageDialog::OTHER,
          Gtk::MessageDialog::BUTTONS_NONE,
          message
        ),
        options, &block
      )
    end

    # A helper method which creates a new +MessageDialog+, adds an OK button,
    # displays it, blocks until 'OK' is clicked, then destroys it.
    # +message+:: The message which the dialog displays.
    def self.show(message)
      dialog = MessageDialog.new(message)
      dialog.add_button('OK', :ok)
      dialog.run
      dialog.destroy
    end
  end
end