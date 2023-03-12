module Dino
  class PWMOut
    include Pin
    
    attr_reader :pwm_channel
    
    def initialize_pins(options={})
      super(options)
      
      # Get a PWM channel from the board, and make sure not to set mode to output!
      @pwm_channel = board.pwm_setup(pin)
      raise "no PWM channels available for given pin: #{options[:pin]}" unless @pwm_channel
    end
    
    def off
      write 0
    end
    
    def on
      # Should calculate max value for resolution.
      write 255
    end
    
    def write(value)
      board.pwm_write(pwm_channel, value)
      self.state = value
    end
  end
end
