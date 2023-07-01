#
# Copied from CRuby gem, except
#   No thread to stop.
#
module Denko
  module PulseIO
    class Buzzer < PWMOutput
      def after_initialize(options={})
        low
      end

      # Duration is in mills
      def tone(frequency, duration=nil)
        board.tone(pin, frequency, duration)
      end

      def no_tone
        board.no_tone(pin)
      end
      
      alias :off  :no_tone
      alias :stop :no_tone
    end
  end
end
