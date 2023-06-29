module Denko
  module Pin
    include Component
  
    attr_accessor :pin, :mode
  
    def initialize_pins(options={})
      mapped_pin = board.map_pin(options[:pin])
      raise "invalid pin given: #{options[:pin]}" unless mapped_pin
    
      options[:pin] = mapped_pin
      self.pin = mapped_pin
    end
  
    def mode=(mode)
      board.pin_mode(self.pin, mode)
    end
  end
end
