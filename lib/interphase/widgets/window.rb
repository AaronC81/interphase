# frozen_string_literal: true

require 'gtk2'

module Interphase
  # An application window.
  class Window < Container
    # Creates a new window.
    def initialize(title, **options, &block)
      super(Gtk::Window.new(title), options, &block)
    end

    # The given block will trigger when this window is closed.
    def on_delete(&block)
      on('delete-event', &block)
    end

    # Registers an #on_delete block which calls #quit.
    def quit_on_delete!
      on_delete do
        quit
      end
    end

    # Runs the entire Interphase application.
    def run
      Gtk.main
    end

    # Quits the entire Interphase application, killing all its threads.
    def quit
      @threads&.each(&:kill)
      Gtk.main_quit
    end

    # Force-quits the entire Interphase application, including the Ruby Kernel.
    # If your GUI quits but your terminal stays occupied after #quit, this will
    # probably solve that issue.
    # Having to use this is usually the sign of a badly-written program!
    def quit!
      @threads&.each(&:kill)
      Gtk.main_quit
      exit!
    end

    # Binds a block to run as a +Thread+; it begins executing immediately.
    # Destroying the window kills all threads.
    # TOOD DOES IT?
    def in_background(&block)
      @threads ||= []
      thread = Thread.new(&block)
      thread.abort_on_exception = true
      @threads << thread
    end
  end
end
