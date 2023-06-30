#
# Copied from main gem, except;
#   No Poller, Listener, @divider, #_listen
#   Don't call #to_i on the read values.
#
module Denko
  module AnalogIO
    class Input
      include Behaviors::InputPin
      include Behaviors::Reader

      def before_initialize(options={})        
        options[:board] = options[:adc] if options[:adc]
        options[:adc] = nil
        super(options)
      end

      def after_initialize(options={})
        super(options)
        
        # If using a negative input on a supported ADC, store the pin.
        @negative_pin = options[:negative_pin]

        # If the ADC has a programmable amplifier, pass through its setting.
        @gain = options[:gain]

        # If using a non-default sampling rate, store it.
        @sample_rate = options[:sample_rate]

        # Default to smoothing disabled.
        @smoothing        = false
        @smoothing_set  ||= []
      end

      attr_reader :negative_pin, :gain, :sample_rate

      # ADCs can set this based on gain, so exact voltages can be calculated.
      attr_accessor :volts_per_bit

      # Usable as a "raw" read method.
      def _read
        board.analog_read(pin, negative_pin, gain, sample_rate)
      end
      
      #
      # !!mruby-optimization
      #   Overrides #read from Behaviors::Reader
      # 
      def read(&block)
        add_callback(:read, &block) if block_given?
        value = board.analog_read(pin, negative_pin, gain, sample_rate)
        self.update(value)
      end
      
      #
      # !!mruby-optimization
      #   Overrides #update from Behaviors::Callbacks
      #   Ignores nil-checking.
      # 
      def update(data)
        filtered_data = pre_callback_filter(data)
        
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
      
      # Attach a callback that only fires when state changes.
      def on_change(&block)
        add_callback(:on_change) do |new_state|
          block.call(new_state) if new_state != self.state
        end
      end

      #
      # Smoothing features.
      # Does a moving average of the last 8 readings.
      #
      attr_accessor :smoothing

      def smooth_input(value)
        # Add new value, but limit to the 8 latest values.
        @smoothing_set << value
        @smoothing_set.shift if @smoothing_set.length > 8
        
        average = @smoothing_set.reduce(:+) / @smoothing_set.length.to_f
        
        # Round up or down based on previous state to reduce fluctuations.
        state && (state > average) ? average.ceil : average.floor
      end

      # Convert data to integer, or pass it through smoothing if enabled.
      def pre_callback_filter(value)
        smoothing ? smooth_input(value) : value
      end
    end
  end
end
