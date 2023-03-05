module Pins
  class AnalogInput
    include SinglePin
    # include Callbacks
    
    def initialize_pins(options={})
      super(options)
      self.mode = :input
    end
        
    def read
      ESP32::GPIO.analog_read(pin)
    end
    
    # on_read
    # shouldn't need a pre_callback_filter since it will already be integer
  end
end
