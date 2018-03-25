# frozen_string_literal: true

require 'gtk2'

module Interphase
  # A basic GTK widget wrapper.
  class Widget < UiObject
    attr_accessor :gtk_instance, :parent, :name

    # Creates a new widget.
    # +gtk_instance+:: The GTK widget instance this is wrapping.
    def initialize(gtk_instance, **options, &block)
      super(gtk_instance, **options, &block)

      @parent = nil
      @name = options[:name]
    end

    # Requests that this widget is resized. Note that this is a method, rather
    # than a 'size=' setter, because the request is not guaranteed, and indeed
    # in many cases will not. Only some containers allow their child widgets
    # to be resized.
    def size(width, height)
      gtk_instance.set_size_request(width, height)
    end

    # Shows this widget.
    def show
      gtk_instance.show
    end

    # Hides this widget.
    def hide
      gtk_instance.hide
    end

    # Respond to lookups by name.
    def method_missing(requested, *args, &block)
      # If any arguments or a block have been given, then this isn't an attr
      if !args.empty? || block_given?
        super
        return
      end

      return self if requested.to_s == name

      super
    end

    def respond_to_missing?(requested)
      requested.to_s == name
    end

    # A list of the transformers applied to this object. Note that
    # Widget#transformers will always return an empty +Array+, but each instance
    # of +Transformer+ will append to this list.
    def transformers
      []
    end
  end

  # A widget which may contain other widgets.
  class Container < Widget
    attr_accessor :children

    # Add a widget as a child of this one.
    # Accepts a block which is executed on the child.
    # +child+:: The new child widget.
    # +should_add+:: (Optional) Whether to actually add the element, or just to
    #                register it as added by adding it to +children+. You
    #                probably shouldn't change this.
    def add(child, should_add = true, &block)
      child.instance_eval(&block) if block_given?

      raise 'Widget already has a parent' unless child.parent.nil?

      gtk_instance.add(child.gtk_instance) if should_add
      child.parent = self

      # Ensure a children array exists, and add the new child to it
      @children ||= []
      children << child
    end

    # Show this widget and all of its children.
    def show_all
      gtk_instance.show_all
    end

    # Allows child named widgets to be looked up like an attribute.
    def method_missing(requested, *args, &block)
      (children || []).each do |child|
        # An exception simply means that wasn't the child we were looking for
        begin
          return child.send(requested)
        rescue NoMethodError
          next
        end
      end

      super
    end

    def respond_to_missing?(requested)
      (children || []).map { |child| child.respond_to?(requested) }.any?
    end
  end
end
