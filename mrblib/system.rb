def sleep(time)
  ESP32::System.delay(time * 1000)
end

def deep_sleep(time)
  ESP32::System.deep_sleep_for(time * 1000)
end
