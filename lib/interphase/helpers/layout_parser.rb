# frozen_string_literal: true

require 'gtk2'

module Interphase
  module Helpers
    # A description of a +Layout+.
    # +rows+:: The number of rows required by the +Grid+ housing the +Layout+.
    # +columns+:: The number of columns required by the +Grid+ housing the +Layout+.
    # +widgets+:: A hash of names to +LayoutPlacement+ objects for child widgets.
    LayoutDescription = Struct.new('LayoutDescription', :rows, :columns, :widgets)

    # An object describing where a widget must be placed inside a layout.
    # +left+:: The column number to attach the left side of the widget to.
    # +right+:: The column number to attach the right side of the widget to.
    # +top+:: The row number to attach the top of the widget to.
    # +bottom+:: The row number to attach the bottom of the widget to.
    LayoutPlacement = Struct.new('LayoutPlacement', :left, :right, :top, :bottom)

    # Provides methods to parse an LDS into a description of a +Grid+, for use
    # with +Layout+.
    class LayoutParser
      attr_reader :input

      # Create a new +LayoutParser+.
      # +input+:: The input LDS.
      def initialize(input)
        @input = input.lines.map(&:strip).reject { |x| x == '' }
      end

      # Gets the number of columns which the LDS contains.
      def columns
        validate

        input.first.length
      end

      # Gets the number of rows which the LDS contains.
      def rows
        validate

        input.length
      end

      # Ensures that the LDS used to create the +LayoutParser+ is valid.
      def validate
        # Checks if all rows are equal
        raise 'Not all rows of equal length' \
          unless input.map(&:length).uniq.length == 1
      end

      # Parses the LDS into a +LayoutDescription+.
      def parse
        validate

        widgets = {}

        input.each_with_index do |line, row|
          line.chars.each_with_index do |char, col|
            widgets[char] = create_placement_from_start(row, col) \
              if widgets[char].nil?
          end
        end

        widgets
      end

      # Creates a +LayoutPlacement+ given a widget's starting position.
      # +start_row+:: The row on which the top-left of the widget occurs.
      # +start_col+:: The column on which the top-left of the widget occurs.
      def create_placement_from_start(start_row, start_col)
        name = input[start_row][start_col]

        # Determine the width of the widget
        current_col = start_col
        width = 0
        while name == input[start_row][current_col]
          width += 1
          current_col += 1
        end

        # Determine the height of the widget
        current_row = start_row
        height = 0
        # input[current_row] could be nil, which would throw due to #[] on nil
        while !input[current_row].nil? && name == input[current_row][start_col]
          height += 1
          current_row += 1
        end

        puts "#{name} starts at #{start_row}, #{start_col}, width #{width}, height #{height}"

        LayoutPlacement.new(
          *position_and_size_to_placement_args(
            start_row,
            start_col,
            width,
            height
          )
        )
      end

      # Converts a start position, width and height into an array of:
      #     [left, right, top, bottom]
      # Suitable for use with a +Grid+ or +LayoutPlacement+.
      def position_and_size_to_placement_args(start_row, start_col, width, height)
        [
          start_col,                # left
          start_col + width - 1,    # right
          start_row,                # top
          start_row + height - 1    # bottom
        ]
      end
    end
  end
end
