module Denko
  class AnalogOut
    include Pin
  
    attr_reader :dac_channel
  
    def initialize_pins(options={})
      # Find DAC channel for pin as given, before it might get overwritten by GPIO mapping.
      @dac_channel = board.map_dac(options[:pin])
      raise "no DAC channel for given pin: #{options[:pin]}" unless @dac_channel
    
      super(options)
      self.mode = :output
    end
  
    def write(value)
      board.dac_write(dac_channel, value)
      self.state = value
    end
  end
end
