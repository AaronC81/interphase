# frozen_string_literal: true

require 'gtk2'
require 'interphase/helpers/observable'

module Interphase
  # A list view which can be populated with objects.
  class ListView < Widget
    attr_reader :rows, :columns

    # Create a new list view.
    # +columns+:: The columns which this list view has, as an +Array+ of
    #             +String+ objects.
    def initialize(columns, **options, &block)
      @columns = columns
      @store = Gtk::ListStore.new(*[String] * columns.length)

      super(Gtk::TreeView.new(@store), options, &block)

      # Init columns
      columns.each_with_index do |col, index|
        renderer = Gtk::CellRendererText.new
        new_col = Gtk::TreeViewColumn.new(col, renderer, text: index)
        gtk_instance.append_column(new_col)
      end

      @rows = Interphase::Helpers::Observable.new([]) { refresh_rows }

      refresh_rows
    end

    # Refreshes the contents of the list view according to its rows. This is
    # called automatically upon mutating #rows.
    def refresh_rows
      @store.clear

      # Insert the rows
      @rows.each do |data_row|
        store_row = @store.append

        # Basically a memcpy
        data_row.each_with_index do |item, index|
          store_row[index] = item
        end
      end
    end

    # Triggers when the selection inside the view changes.
    # The block is passed a single argument, the selected row as an array.
    def on_select
      gtk_instance.selection.signal_connect('changed') do |selection|
        data = (0...columns.length).map { |i| selection.selected[i] }

        yield(data)
      end
    end
  end
end
