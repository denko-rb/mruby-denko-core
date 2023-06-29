#
# Copied form main gem, except:
#   No Poller, Listener, so no #after_initialize needed, no #_listen
#   Values will already be integers, so no #pre_callback_filter needed
#
module Dino
  module DigitalIO
    class Input
      include Behaviors::InputPin
      include Behaviors::Reader
      
      def _read
        board.digital_read(pin)
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
