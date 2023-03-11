module Dino
  class AnalogIn
    include Pin
  
    attr_reader :adc_channel
  
    def initialize_pins(options={})
      # Find ADC channel for pin as given. It may get overwritten later in GPIO mapping.
      @adc_channel = board.map_adc(options[:pin])
      raise "no ADC channel for given pin: #{options[:pin]}" unless @adc_channel
    
      super(options)
      self.mode = :input
    end
      
    def read
      self.state = board.adc_read(adc_channel)
    end
  end
end
