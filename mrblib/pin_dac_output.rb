module Pins
  class DACOutput
    include SinglePin
    
    attr_reader :dac_channel
    
    def initialize_pins(options={})
      # Find DAC channel for pin as given, before it might get overwritten by GPIO mapping.
      @dac_channel = Pins.map_dac(options[:pin])
      raise "no DAC channel for given pin: #{options[:pin]}" unless @dac_channel
      
      super(options)
      self.mode = :output
    end
    
    def write(value)
      ESP32::GPIO.analog_write(dac_channel, value)
      self.state = value
    end
  end
end
