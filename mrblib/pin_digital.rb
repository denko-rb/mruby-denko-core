module Pins
  class Digital
    include SinglePin
    include Callbacks
    
    HIGH = 1
    LOW = 0
    
    # Reading methods
    def _read
      board.digital_read(pin)
    end
    
    def on_high(&block)
      add_callback(:high) do |value|
        block.call(value) if value == HIGH
      end
    end
    
    def on_low(&block)
      add_callback(:low) do |value|
        block.call(value) if value == LOW
      end
    end
    
    def initialize_pins(options={})
      super(options)
      self.mode = options[:mode] if options[:mode]
    end
    
    # Writing methods
    def digital_write(value)
      board.digital_write(pin, value)
      self.state = value
    end
    
    alias :write :digital_write
    
    def low
      digital_write(LOW)
    end
    
    def high
      digital_write(HIGH)
    end
    
    alias :off :low
    alias :on  :high
    
    def toggle
      state == LOW ? high : low
    end
    
    def high?; state == HIGH end
    def low?;  state == LOW  end
  end
end
