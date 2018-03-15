# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A grid which contains rows and columns containing other widgets.
  # Note that grid cells will be as large as they can be; if you create a 4x4
  # grid but only insert one item into it, then that item will fill the entire
  # grid's allocated space.
  class Grid < Container
    # Create a new grid.
    def initialize(rows, columns, **options, &block)
      super(Gtk::Table.new(rows, columns), **options, &block)
    end

    # Add a child to the grid.
    # +child+:: The new child widget.
    # +left+:: The column number to attach the left side of the widget to.
    # +right+:: The column number to attach the right side of the widget to.
    # +top+:: The row number to attach the top of the widget to.
    # +bottom+:: The row number to attach the bottom of the widget to.
    def add(child, left, right, top, bottom, &block)
      super(child, false, &block)

      gtk_instance.attach(child.gtk_instance, left, right, top, bottom)
    end

    # Retrieve the number of columns this grid has.
    def columns
      gtk_instance.columns
    end

    # Retrieve the number of rows this grid has.
    def rows
      gtk_instance.rows
    end
  end
end
