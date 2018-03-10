# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A button which can perform an action upon being clicked.
  class Button < Widget
    # Create a new button.
    # +label+:: The text to display on the button.
    def initialize(label = '', **options, &block)
      super(Gtk::Button.new(label), **options, &block)
    end

    # Get the button's label text.
    def label
      gtk_instance.label
    end

    # Set the button's label text.
    def label=(value)
      gtk_instance.label = value
    end

    # Register a block to execute upon clicking the button.
    def on_click(&block)
      on('clicked', &block)
    end

    # Clicks the button, executing any blocks added using +#on_click+.
    def click
      gtk_instance.clicked
    end
  end
end
