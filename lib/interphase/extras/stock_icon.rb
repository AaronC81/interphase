# frozen_string_literal: true

require 'gtk2'

module Interphase
  # Wraps GTK's stock icons.
  # TODO: This is unstable and could be vastly improved.
  class StockIcon
    attr_reader :icon

    private_class_method :new
    def initialize(icon)
      @icon = icon
    end

    def self.const_missing(name)
      new(Gtk::Stock.const_get(name.upcase).to_s)
    rescue NameError
      super
    end
  end
end
