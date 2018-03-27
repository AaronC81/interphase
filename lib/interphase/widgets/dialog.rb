# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A base class representing a simple, blank dialog box.
  class Dialog < Widget
    # Construct a new blank dialog box.
    def initialize(instance = nil, **options, &block)
      super(instance || Gtk::Dialog.new, **options, &block)

      options['buttons']&.map { |btn| add_button(*btn) }
    end

    # Converts an +#add_button+ +action+ symbol to the GTK RESPONSE integer
    # which it represents.
    # +action+:: The action symbol to convert. Should be one of the valid
    #            values of +action+ to +#add_button+.
    def action_to_integer(action)
      valid_actions =
        %i[none reject accept delete ok cancel close yes no apply help]

      throw ArgumentError, 'Invalid button action' \
        unless valid_actions.include? action

      # Map :delete to its GTK equivalent
      action = :delete_event if action == :delete

      Gtk::Dialog.const_get("RESPONSE_#{action.to_s.upcase}")
    end

    # Adds a button to the dialog box.
    # +text+:: The text to display on the button.
    # +action+:: The action which occurs when this button is clicked. Must be
    #            one of: +:none+, +:reject+, +:accept+, +:delete+, +:ok+,
    #            +:cancel+, +:close+, +:yes+, +:no+, +:apply+, +:help+.
    def add_button(text, action)
      gtk_instance.add_button(text, action_to_integer(action))
      nil
    end

    # Run this dialog box. This call will block execution until the dialog is
    # closed. Consider using +Window#in_background+ if blocking is not desired.
    # You should usually call +destroy+ after this method, otherwise the dialog
    # will remain even after selecting an option.
    def run
      gtk_instance.run
    end
  end
end
