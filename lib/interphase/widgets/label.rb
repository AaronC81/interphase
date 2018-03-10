# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A text label.
  class Label < Widget
    # Creates a new label.
    def initialize(text = '', **options, &block)
      super(Gtk::Label.new(text), options, &block)
    end

    # Set the text in this label.
    def text=(value)
      gtk_instance.text = value
    end

    # Retrieve the label's text.
    def text
      gtk_instance.text
    end
  end
end
