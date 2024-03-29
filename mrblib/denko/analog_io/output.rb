#
# Copied form main gem, except:
#   No Threaded, so no #interrupt_with
#   No Callbacks or reading initial state, so no #after_initialize, no #pre_callback_filter
#   :output_dac mode does not exist, so no need for #initialize_pins
#   State is set through instance variable instead of #state= method. Don't care about mutex.
#
module Denko
  module AnalogIO
    class Output
      include Behaviors::OutputPin
      
      def write(value)
        @board.dac_write(@pin, value)
        @state = value
      end
    end
  end
end
