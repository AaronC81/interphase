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

    # Runs this window as an Interphase application. Note that this calls 
    # #quit_on_delete! so the program will stop when this window is closed.
    def run
      quit_on_delete!
      Gtk.main
    end

    # Quits the entire Interphase application, killing all its threads.
    def quit
      @threads&.each do |t|
        t.kill.join
      end
      Gtk.main_quit
    end

    # Force-quits the entire Interphase application, including the Ruby Kernel.
    # If your GUI quits but your terminal stays occupied after #quit, this will
    # probably solve that issue.
    # Having to use this is usually the sign of a badly-written program!
    def quit!
      quit
      exit!
    end

    # Binds a block to run as a +Thread+; it begins executing immediately.
    # Destroying the window kills all threads.
    def in_background(&block)
      @threads ||= []
      thread = Thread.new(&block)
      thread.abort_on_exception = true
      @threads << thread
      thread
    end
  end
end
