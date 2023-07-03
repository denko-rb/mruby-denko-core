#
# Copied form main gem, except:
#   No Threaded, so no #interrupt_with
#   No Callbacks or reading initial state, so no #after_initialize, no #pre_callback_filter
#     Maybe default to :input_output mode to make it readable?
#   State is set through instance variable instead of #state= method. Don't care about mutex.
#
module Denko
  module DigitalIO
    class Output
      include Behaviors::OutputPin

      def digital_write(value)
        @board.digital_write(@pin, value)
        @state = value
      end
      
      alias :write :digital_write

      def low
        digital_write(0)
      end

      def high
        digital_write(1)
      end
      
      def toggle
        state == 1 ? digital_write(0) : digital_write(1)
      end
      
      alias :off :low
      alias :on  :high
      
      def high?; state == 1 end
      def low?;  state == 0 end
      
      alias :on?  :high?
      alias :off? :low?
    end
  end
end
