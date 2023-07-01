#
# Copied form main gem, except:
#   No Poller, Listener, so no #after_initialize needed, no #_listen
#   Values will already be integers, so no #pre_callback_filter needed
#
module Denko
  module DigitalIO
    class Input
      include Behaviors::InputPin
      include Behaviors::Reader
      
      # Usable as a "raw" read method.
      def _read
        board.digital_read(pin)
      end
      
      #
      # !!mruby-optimization
      #   Overrides #read from Behaviors::Reader
      # 
      def read(&block)
        add_callback(:read, &block) if block_given?
        value = board.digital_read(pin)
        self.update(value) if value != state
      end
      
      #
      # !!mruby-optimization
      #   Overrides #update from Behaviors::Callbacks
      #   Bypasses #pre_callback_filter
      #   Ignores nil-checking.
      # 
      def update(data)        
        @callbacks.each_value do |array|
          array.each do |callback|
            callback.call(data)
          end
        end
        
        # Remove one-time callbacks added by #read.
        @callbacks.delete(:read)

        update_state(data)
        data
      end
      
      def on_high(&block)
        add_callback(:high) do |data|
          block.call(data) if data.to_i == board.high
        end
      end
      
      def on_low(&block)
        add_callback(:low) do |data|
          block.call(data) if data.to_i == board.low
        end
      end
      
      def high?; state == board.high end
      def low?;  state == board.low  end
    end
  end
end
