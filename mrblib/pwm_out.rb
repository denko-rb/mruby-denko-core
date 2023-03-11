module Dino
  class PWMOut < DigitalInOut
    # No LEDC implementation yet
  
    def write(value)
      board.pwm_write(pin, value)
    end
  end
end
