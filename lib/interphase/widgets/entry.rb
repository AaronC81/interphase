# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A box containing text which can be edited by the user.
  class Entry < Widget
    attr_reader :text

    # Creates a new text entry widget.
    def initialize(text="", **options, &block)
      super(Gtk::Entry.new, **options, &block)
      @text = text
    end

    # Sets the text inside the widget.
    def text=(value)
      # Value is frozen to prevent modification without updating the text on the
      # widget (i.e. mutation must be through this method)
      @text = value.clone.freeze

      gtk_instance.text = text
    end
  end
end
