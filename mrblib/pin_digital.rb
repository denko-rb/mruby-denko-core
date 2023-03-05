module Pins
  class Digital
    include SinglePin
    # include Callbacks
    
    def initialize_pins(options={})
      super(options)
      self.mode = options[:mode] if options[:mode]
    end
    
    def read
      ESP32::GPIO.digital_read(pin)
    end
    
    def digital_write(value)
      ESP32::GPIO.digital_write(pin, value)
      self.state = value
    end
    
    alias :write :digital_write
    
    def low
      digital_write(LOW)
    end
    
    def high
      digital_write(HIGH)
    end
    
    # on_high and on_low
    # shouldn't need a pre_callback_filter since it will already be integer
    
    alias :off :low
    alias :on  :high
    
    def toggle
      state == LOW ? high : low
    end
    
    def high?; state == HIGH end
    def low?;  state == LOW  end
  end
end
