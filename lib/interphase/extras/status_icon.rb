# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A tray status icon.
  class StatusIcon
    attr_reader :gtk_instance

    def initialize(tooltip)
      @gtk_instance = Gtk::StatusIcon.new
      self.tooltip = tooltip
    end

    def on(event, &block)
      @gtk_instance.signal_connect(event, &block)
    end

    def on_click(&block)
      on('activate', &block)
    end

    def tooltip
      @gtk_instance.tooltip
    end

    def tooltip=(value)
      @gtk_instance.tooltip = value
    end

    def icon=(icon)
      raise ArgumentError, 'Must be a StockIcon' unless icon.is_a? StockIcon

      @gtk_instance.set_stock(icon.icon)
    end
  end
end
