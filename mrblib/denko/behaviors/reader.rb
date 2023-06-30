#
# Copied from main gem, except:
#   No #block_until_read
#
module Denko
  module Behaviors
    module Reader
      include Callbacks
      #
      # Defalt behavior for #read is to delegate to #_read.
      # Define #_read in including classes.
      #
      def read(*args, **kwargs, &block)
        read_using(self.method(:_read), *args, **kwargs, &block)
      end

      #
      # Delegate reading to another method. 
      # Accepts blocks as one-time callbacks stored in the :read key.
      # Returns the value passed through #pre_callback_filter.
      #
      def read_using(method, *args, **kwargs, &block)
        add_callback(:read, &block) if block_given?
        value = method.call(*args, **kwargs)
        
        # Returns value after #pre_callback_filter
        self.update(value)
      end
      
      def _read
        raise NotImplementedError, "#{self.class.name}#_read is not defined."
      end
    end
  end
end
 