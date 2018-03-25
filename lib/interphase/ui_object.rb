# frozen_string_literal: true

module Interphase
  # A base class for all Interphase objects, which may have events or be
  # destroyed.
  class UiObject
    attr_reader :gtk_instance

    # Creates a new UI object.
    # +gtk_instance+:: The GTK widget instance this is wrapping.
    def initialize(gtk_instance, **options, &block)
      @gtk_instance = gtk_instance

      instance_eval(&block) if block_given?
    end

    # Associates a block with a signal. The block is invoked whenever the
    # signal occurs.
    # +name+:: The name of the signal.
    def on(name, &block)
      gtk_instance.signal_connect(name, &block)
    end

    # Destroy this widget.
    def destroy
      gtk_instance.destroy
    end
  end
end
