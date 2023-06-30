#
# Copied from main gem, except:
#  No Mutex
#  #update returns filtered_data
#
module Denko
  module Behaviors
    module Callbacks
      include State
      
      def initialize(options={})
        remove_callbacks
        super(options)
      end
      
      def callbacks
        @callbacks
      end
      
      def add_callback(key=:persistent, &block)
        @callbacks[key] ||= []
        @callbacks[key] << block
      end

      def remove_callback(key=nil)
        key ? @callbacks.delete(key) : @callbacks = {}
      end

      alias :on_read :add_callback
      alias :remove_callbacks :remove_callback

      def update(data)
        # nil will unblock #read without running callbacks.
        unless data
          remove_callback(:read)
          return nil
        end

        filtered_data = pre_callback_filter(data)

        # nil will unblock #read without running callbacks.
        unless filtered_data
          remove_callback(:read)
          return nil
        end

        @callbacks.each_value do |array|
          array.each do |callback|
            callback.call(filtered_data)
          end
        end
        # Remove one-time callbacks added by #read.
        @callbacks.delete(:read)

        update_state(filtered_data)
        filtered_data
      end
  
      # Override to process data before giving to callbacks and state.
      def pre_callback_filter(data)
        data
      end
    end
  end
end
