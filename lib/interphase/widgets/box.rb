# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A simple item container. You should use +VBox+ or +HBox+ rather than this.
  class Box < Container
    # Add a widget to the box, after all others added at the same reference.
    # Accepts a block which is executed on the child.
    # +child+:: The new child widget.
    # +expand+:: (Optional) Allocate extra space to this widget, default +true+.
    # +fill+:: (Optional) Allocate to the full width/height of the box, default
    #          +true+.
    # +padding+:: (Optional) Any padding to allocate to this widget, default 0.
    # +ref+:: (Optional) The reference at which to add the widget. Either
    #         +:start+ (default) or +:end+.
    def add(child,
            expand = true,
            fill = true,
            padding = 0,
            ref = :start,
            &block)
      super(child, false, &block)

      if ref == :start
        gtk_instance.pack_start(child.gtk_instance, expand, fill, padding)
      elsif ref == :end
        gtk_instance.pack_end(child.gtk_instance, expand, fill, padding)
      else
        raise 'ref should be either PACK_START or PACK_END'
      end
    end
  end

  # A vertical item container.
  class VBox < Box
    # Creates a new vertical box.
    def initialize(**options, &block)
      super(Gtk::VBox.new, options, &block)
    end
  end

  # A horizontal item container.
  class HBox < Box
    # Creates a new horizontal box.
    def initialize(**options, &block)
      super(Gtk::HBox.new, options, &block)
    end
  end
end
