# frozen_string_literal: true

require 'gtk2'
require 'interphase/helpers/observable'

module Interphase
  # A simple list view which displays an +Array+.
  class SimpleListView < ListView
    attr_reader :items

    def initialize(items = [], **options, &block)
      super(['Column'], options, &block)

      gtk_instance.headers_visible = false

      @items = Interphase::Helpers::Observable.new(items) do
        refresh_items
      end

      refresh_items
    end

    # Copies #items into #rows, where each item is one row.
    def refresh_items
      rows.clear

      items.each do |item|
        rows << [item]
      end
    end
  end
end
