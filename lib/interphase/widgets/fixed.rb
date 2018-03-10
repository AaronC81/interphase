# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A container in which items can be placed in a specific x/y location.
  class Fixed < Container
    # Construct a new fixed container.
    def initialize(**options, &block)
      super(Gtk::Fixed.new, **options, &block)
    end

    # Add a child widget to this +Fixed+ at a location.
    # +child+:: The new child widget.
    # +x_pos+:: The x position.
    # +y_pos+:: The y position.
    def add(child, x_pos, y_pos, &block)
      gtk_instance.put(child.gtk_instance, x_pos, y_pos)

      super(child, false, &block)
    end
  end
end
