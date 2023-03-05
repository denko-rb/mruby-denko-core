module Pins
  class DACOutput
    def initialize_pins(options={})
      super(options)
      self.mode = :output
    end
    
    def write(value)
      ESP32::GPIO.analog_write(pin, value)
      self.state = value
    end
  end
end
