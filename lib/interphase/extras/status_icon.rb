# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A tray status icon.
  class StatusIcon < UiObject
    def initialize(tooltip)
      @gtk_instance = Gtk::StatusIcon.new
      self.tooltip = tooltip
    end

    def on_click(&block)
      on('activate', &block)
    end

    gtk_passthrough :tooltip, 'Get this icon\'s tooltip.'
    gtk_passthrough :tooltip=, 'Set this icon\'s tooltip.'

    def icon=(icon)
      raise ArgumentError, 'Must be a StockIcon' unless icon.is_a? StockIcon

      @gtk_instance.set_stock(icon.icon)
    end
  end
end
