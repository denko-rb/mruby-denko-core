# mruby-dino-core

mruby implementation of the core [dino](https://github.com/austinbv/dino) features, running directly on the ESP32 chip. Depends on [mruby-esp32](https://github.com/mruby-esp32).

### Missing Features

* PWMOut resolution and frequency is not configurable yet. Always 8-bit at 1kHz for now (Arduino defaults).
* Can't request specific PWM (LEDC for ESP32) channels and timers from the board yet. Distributed them in the ESP32 gem to match Arduino defaults. Could make this more configurable.
* DAC and ADC resolutions are not configureable yet. DAC is 8-bit output, ADC is 12-bit input.

### Key Differences

* Namespace:
  * Naming is different to the main Ruby gem, but that will probably be updated to match this. Most importantly, the `Components` module isn't being used and most components will be at the top level of the `Dino` namespace.

* Component Differences:
  * Components can initialize with a `board:` option, for future board proxy components, but it is not required. It will default to the global variable `$board` which is an instance representing the ESP32 board itself.
  * The `pullup:` and `pulldown:` options will do nothing when initializing a component. The ESP32 handles that within pin mode setting. Use `mode:` in options hash instead. The valid modes are:
     * `:input`
     * `:input_pullup`
     * `:input_pulldown`
     * `:input_output`
     * `:output`
  * `DigitalInOut` replaces both `DigitalOutput` and `DigitalInput`.
  * `AnalogOut` and `PWMOut` replace `AnalogOutput`.
  * `AnalogOut` is for pins with DACs only: GPIO25 and GPIO26.
  * `PWMOut` works on any PWM-capable pin and will not use the DAC. Defaults to 8-bit resolution and 1kHz.
  * `AnalogIn` replaces `AnalogInput`.
  * `AnalogIn` only works for ADC1, on these GPIOs pins: 32, 33, 34, 35, 36/SensVP, 39/SensVN
  * `AnalogIn` defaults to 12 bits.

* Threading:
  * Components do not implement `Dino::Mixins::Threaded` for doing "background" tasks like `Led#blink`, since there is only one thread.
  * `Component#state` is not protected by a mutex, since no threading.
  
* Inputs & Callbacks:
  * Callbacks are NOT included by default on any of the low level components that might be rapidly polled. Hash and Array enumeration is just too slow. Will implement it for slower reading senors only, or maybe an alternative implementation with a single callback instead of many.
  * Some components will implement `#previous_state` for easy comparison after reading.
  * Components don't implement `#_poll`, `#poll`, `#_listen` or `#listen`, and in most cases no `#_read` either, just `#read`. User is responsible for reading the component as needed.
  * The `#on_data` callback adder has been renamed to `#on_read`.
  * Callbacks and state are not protected by mutexes, since no direct interaction between mruby processes.
