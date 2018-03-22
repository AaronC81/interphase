# frozen_string_literal: true

require 'gtk2'

module Interphase
  # Transforms a widget by allowing it to scroll horizontally and vertically.
  class ScrollingTransformer < Transformer
    def initialize(widget, &block)
      super(widget, ::Gtk::ScrolledWindow.new, &block)
      gtk_instance.add(widget.gtk_instance)
    end

    def info
      { type: ScrollingTransformer }
    end
  end
end
