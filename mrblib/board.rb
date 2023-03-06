class Board
  include ESP32::GPIO
  
  def pin_mode(gpio, mode)
    case mode
    when :input_pullup;   ESP32::GPIO.pin_mode(gpio, ESP32::GPIO::INPUT_PULLUP)
    when :input_pulldown; ESP32::GPIO.pin_mode(gpio, ESP32::GPIO::INPUT_PULLDOWN)
    when :input;          ESP32::GPIO.pin_mode(gpio, ESP32::GPIO::INPUT)
    when :output;         ESP32::GPIO.pin_mode(gpio, ESP32::GPIO::INPUT_OUTPUT)
    when :input_output;   ESP32::GPIO.pin_mode(gpio, ESP32::GPIO::INPUT_OUTPUT)  
    else raise "invalid mode given: #{mode}"
    end
  end
  
  def digital_write(pin, value)
    ESP32::GPIO.digital_write(pin, value)
  end
  
  def digital_read(pin)
    ESP32::GPIO.digital_read(pin)
  end
  
  def dac_write(dac_channel, value)
    ESP32::GPIO.analog_write(dac_channel, value)
  end
  
  def adc_read(adc_channel)
    ESP32::GPIO.analog_read(adc_channel)
  end
  
  def pwm_write
  end
  
  # GPIO map for the original ESP32.
  # Need to change this depending on which variant is being used.
  GPIO_MAP = [
    GPIO_NUM_0,
    GPIO_NUM_1,
    GPIO_NUM_2,
    GPIO_NUM_3,
    GPIO_NUM_4,
    GPIO_NUM_5,
    GPIO_NUM_6,
    GPIO_NUM_7,
    GPIO_NUM_8,
    GPIO_NUM_9,
    GPIO_NUM_10,
    GPIO_NUM_11,
    GPIO_NUM_12,
    GPIO_NUM_13,
    GPIO_NUM_14,
    GPIO_NUM_15,
    GPIO_NUM_16,
    GPIO_NUM_17,
    GPIO_NUM_18,
    GPIO_NUM_19,
    nil,
    GPIO_NUM_21,
    GPIO_NUM_22,
    GPIO_NUM_23,
    nil,
    GPIO_NUM_25,
    GPIO_NUM_26,
    GPIO_NUM_27,
    nil,
    nil,
    nil,
    nil,
    GPIO_NUM_32,
    GPIO_NUM_33,
    GPIO_NUM_34,
    GPIO_NUM_35,
    GPIO_NUM_36,
    GPIO_NUM_37,
    GPIO_NUM_38,
    GPIO_NUM_39,
  ]
  
  ADC1_MAP = {
    36 => ADC1_CHANNEL_0,
    37 => ADC1_CHANNEL_1,
    38 => ADC1_CHANNEL_2,
    39 => ADC1_CHANNEL_3,
    32 => ADC1_CHANNEL_4,
    33 => ADC1_CHANNEL_5,
    34 => ADC1_CHANNEL_6,
    35 => ADC1_CHANNEL_7
  }
  
  DAC_MAP = {
    25 => DAC_CHANNEL_1,
    26 => DAC_CHANNEL_2,
  }
  
  def map_pin(number)
    GPIO_MAP[number]
  end
  
  def map_adc(number)
    ADC1_MAP[number]
  end
  
  def map_dac(number)
    DAC_MAP[number]
  end
end

$board = Board.new