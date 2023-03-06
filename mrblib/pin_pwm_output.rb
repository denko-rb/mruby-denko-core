module Pins
  class PWMOutput < Digital
    # No LEDC implementation yet
    
    def write(value)
      board.pwm_write(pin, value)
    end
  end
end
