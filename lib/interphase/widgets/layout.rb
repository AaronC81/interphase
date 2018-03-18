# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A high-level widget which is described using a layout description string,
  # abbreviated to LDS. The LDS specifies a grid in which there are a fixed
  # number of widgets occupying a fixed space.
  class Layout < Grid
    attr_reader :lds, :description

    # Create a new layout.
    # +lds+:: The LDS to create the grid from.
    def initialize(lds, **options, &block)
      @lds = lds
      parser = Helpers::LayoutParser.new(lds)

      @description = parser.parse
      @set_slot_names = []

      super(parser.rows, parser.columns, **options, &block)
    end

    # Set the widget contained within a slot. This may only be done once per
    # slot.
    # +slot+:: The name of the slot.
    # +widget+:: The widget to put in the slot.
    def []=(name, widget)
      raise "Already set a widget for slot named #{name}" \
        if @set_slot_names.include? name

      raise "No slot named #{name}" unless @description.widgets.include? name

      @set_slot_names << name
      slot_description = @description.widgets[name]
      
      add(
        widget,
        slot_description.left,
        slot_description.right,
        slot_description.top,
        slot_description.bottom
      )
    end
  end
end
