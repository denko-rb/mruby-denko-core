#
# Similar to main gem, except:
#   Doesn't inherit from DigitalIO::Output since output mode must not be set to output. Includes SinglePin instead.
#   No Threaded, so no #interrupt_with
#   Does not try to call Board#digital_write at all.
#   No #pwm_enable or #pwm_disable
#   Should implement "disconnected" state or whatever it's called on ESP32 for this.
#
module Denko
  module PulseIO
    class PWMOutput
      include Behaviors::SinglePin
      
      def pwm_write(value)
        board.pwm_write(pin, @state=value)
      end
      alias :write :pwm_write
      
      # Repeated from DigitalIO::Output.
      # Not sure if should inherit and switch between PWM and digital modes like CRuby.
      #
      # Currently limited to 8-bits.
      # Board needs to implement pwm_high, dac_high and adc_high still.
      # 
      def low
         board.pwm_write(pin, @state=0)
      end

      def high
        board.pwm_write(pin, @state=255)
      end
      
      def toggle
        state == board.low ? high : low
      end
      
      alias :off :low
      alias :on  :high
      
      def high?; state == 255 end
      def low?;  state == 0   end
      
      alias :on?  :high?
      alias :off? :low?
    end
  end
end
