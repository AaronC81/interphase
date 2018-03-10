# frozen_string_literal: true

require 'gtk2'

module Interphase
  # Provides a simple status bar which can display a single message.
  class SimpleStatusBar < Widget
    attr_reader :text

    # Create a new simple status bar.
    def initialize(**options, &block)
      super(Gtk::Statusbar.new, options, &block)
    end

    # Sets the text displayed in the status bar.
    def text=(value)
      # Value is frozen to prevent modification without updating the text on the
      # widget (i.e. mutation must be through this method)
      @text = value.clone.freeze

      begin
        gtk_instance.pop(1)
      rescue StandardError # rubocop:disable Lint/HandleExceptions
        # It doesn't matter; just means that there was no text previously
      end

      gtk_instance.push(1, text)
    end
  end
end
