# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A text label.
  class Label < Widget
    attr_reader :text

    # Creates a new label.
    def initialize(text = '', **options, &block)
      super(Gtk::Label.new(text), options, &block)
      @text = text
    end

    # Set the text in this label.
    def text=(value)
      @text = value.clone.freeze

      gtk_instance.text = text
    end
  end
end
