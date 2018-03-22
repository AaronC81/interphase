# frozen_string_literal: true

module Interphase
  # A base class for transformers, classes which extend a widget with a new
  # capability. Transformers act like proxies, passing most calls to the widget
  # they're wrapping unmodified, except:
  #     - #gtk_instance, which returns a 'wrapped' version of the original
  #     - #transformers, which is appended with one item per transformer

  # TODO: A more robust way of handling #send is definitely required.
  class Transformer < BasicObject
    attr_reader :__widget__, :gtk_instance

    def initialize(widget, new_instance, &block)
      widget.instance_eval(&block) if ::Kernel.block_given?
      @__widget__ = widget
      @gtk_instance = new_instance
    end

    def respond_to?(name)
      __widget__.respond_to?(name)
    end

    def respond_to_missing?(name)
      respond_to?(name)
    end

    def method_missing(name, *args, &block)
      # Check for direct by-name access
      return self if __widget__.name == name.to_s && args.empty?

      # Check for send
      return self \
        if name == :send \
        && args.length == 1 \
        && args[0].to_s == __widget__.name.to_s

      __widget__.send(name, *args, &block)
    end

    # Returns some information about this transformer as a hash. This hash
    # should always include the :type key, set to the transformer class.
    def info
      { type: Transformer }
    end

    def transformers
      __widget__.transformers + [info]
    end
  end
end
