module Pins
  module SinglePin
    include Base
    include ESP32::GPIO
    
    attr_accessor :pin, :mode
    
    def initialize_pins(options={})
      mapped_pin = Pins.map_pin(options[:pin])
      raise "invalid pin given #{options[:pin]}" unless mapped_pin
      
      options[:pin] = mapped_pin
      self.pin = mapped_pin
    end
    
    def mode=(mode)
      case mode
      when :input_pullup;   ESP32::GPIO.pin_mode(pin, ESP32::GPIO::INPUT_PULLUP)
      when :input_pulldown; ESP32::GPIO.pin_mode(pin, ESP32::GPIO::INPUT_PULLDOWN)
      when :input;          ESP32::GPIO.pin_mode(pin, ESP32::GPIO::INPUT)
      when :output;         ESP32::GPIO.pin_mode(pin, ESP32::GPIO::INPUT_OUTPUT)
      when :input_output;   ESP32::GPIO.pin_mode(pin, ESP32::GPIO::INPUT_OUTPUT)  
      else raise "invalid pin mode given: #{mode}"
      end
    end
  end
end
