# frozen_string_literal: true

module Interphase
  module Helpers
    # An object wrapper which can invoke a method whenever the wrapped object
    # changes.
    # Unlike most classes, this class inherits from `BasicObject`, which has
    # absolutely no methods whatsoever. This means that everything, even
    # +inspect+ and +class+, fall into +Observable#method_missing+.
    class Observable < BasicObject
      # Wrap an object in a new instance of +Observable+.
      # Takes a block which executes upon the object changing. This block is
      # passed +object+ as a paremeter.
      # +object+:: The object to wrap.
      def initialize(object, &block)
        # :: is required because we inherit BasicObject, not Object
        ::Kernel.raise ::ArgumentError, 'Requires a block' unless ::Kernel.block_given?

        @object = object
        @on_change = block
      end

      def respond_to?(name)
        @object.respond_to?(name)
      end

      def method_missing(name, *args, &block)
        if @object.respond_to?(name)
          before_hash = @object.hash
          ret_val = @object.send(name, *args, &block)
          after_hash = @object.hash

          @on_change.call(@object) if before_hash != after_hash

          ret_val
        else
          super
        end
      end

      def respond_to_missing?(*)
        true
      end
    end
  end
end
