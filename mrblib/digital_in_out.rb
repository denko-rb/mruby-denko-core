module Denko
  class DigitalInOut
    include Pin
  
    HIGH = 1
    LOW = 0
  
    # Reading Methods
    def initialize_pins(options={})
      super(options)
      self.mode = options[:mode] if options[:mode]
    end

    def read
      self.previous_state = state
      self.state = board.digital_read(pin)
    end
    
    def rose?
      (previous_state == LOW) && (state == HIGH)
    end
    
    def fell?
      (previous_state == HIGH) && (state == LOW)
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
