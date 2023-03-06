module Pins
  class AnalogInput
    include SinglePin
    include Callbacks
    
    attr_reader :adc_channel
    
    def initialize_pins(options={})
      # Find ADC channel for pin as given, before it might get overwritten by GPIO mapping.
      @adc_channel = Pins.map_adc(options[:pin])
      raise "no ADC channel for given pin: #{options[:pin]}" unless @adc_channel
      
      super(options)
      self.mode = :input
    end
        
    def _read
      ESP32::GPIO.analog_read(adc_channel)
    end
  end
end
