module Pins
  class AnalogInput
    include SinglePin
    include Callbacks
    
    def initialize_pins(options={})
      super(options)
      self.mode = :input
    end
        
    def _read
      ESP32::GPIO.analog_read(pin)
    end
  end
end
