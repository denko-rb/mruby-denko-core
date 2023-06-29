#
# Copied form main gem, except:
#   No Threaded, so no #interrupt_with
#   No Callbacks or reading initial state, so no #after_initialize, no #pre_callback_filter
#     Maybe default to :input_output mode to make it readable?
#
module Dino
  module DigitalIO
    class Output
      include Behaviors::OutputPin

      def digital_write(value)
        board.digital_write(pin, value)
        self.state = value
      end
      
      alias :write :digital_write

      def low
        digital_write(board.low)
      end

      def high
        digital_write(board.high)
      end
      
      def toggle
        state == board.low ? high : low
      end
      
      alias :off :low
      alias :on  :high
      
      def high?; state == board.high end
      def low?;  state == board.low  end
      
      alias :on?  :high?
      alias :off? :low?
    end
  end
end
