# mruby-dino-core-esp32

mruby implementation of the core [dino](https://github.com/austinbv/dino) features, running directly on the ESP32 chip. Depends on [mruby-esp32](https://github.com/mruby-esp32).


### Core Features Not Implemented Yet

* PWM output
* `AnalogInput` doesn't work right yet. The GPIO pins aren't properly mapped to the ADC channels. It works if by overriding the pin with `sensor.pin = ESP32::GPI::ADC1_CHANNEL_X`, where X is the channel number on ADC1 that maps to the GPIO pin.

### Key Differences

* Namespace:
  * Low-level components are inside `Pins`, rather than `Dino::Components::Basic` or `Dino::Components::Setup`.
  * Higher level components will go in the top level namespace, not `Dino::Components`.
  * The `Dino` namespace isn't really used, expect to set the version number.
  
* Component Differences:
  * There is no `Board` class, or `board:` requirement to initialize a component. Might need as an option for registers later.
  * `DigitalOutput` and `DigitalInput` components are both replaced by `Pins::Digital`, which can act as both.
  * The `AnalogOutput` class is replaced by `Pins::DACOutput` and `Pins::PWMOutput`, for DAC and PWM output respectively.
  * The `pullup:` and `pulldown:` options will do nothing when initializing a component. The ESP32 handles that within pin mode setting. Use `component#mode=` instead. The valid modes are:
     * `:input`
     * `:input_pullup`
     * `:input_pulldown`
     * `:input_output`
     * `:output`
  * Will add a `mode:` option to the single pin initilization hash too.
  * `AnalogInput` should use only these GPIOs: 32, 33, 34, 35, 36/SensVP, 39/SensVN
  * `AnalogInput` defaults to 12 bits.

* Threading:
  * Components do not implement `Dino::Mixins::Threaded` for doing "background" tasks like `Led#blink`, since there is only one thread.
  * `Component#state` is not protected by a mutex, since no threading.
  
* Inputs & Callbacks:
  * Components don't implement `#_poll`, `#poll`, `#_listen` or `#listen`, since there is no threading.
  * Components implement `#_read`, which reads and returns the value immediately, without filtering, running callbacks, or updating `state` with it. Might be useful for speed?
  * Components implement `#read`, which reads the value, filters it, then runs callbacks and updates `state`.
  * The `#on_data` callback adder has been renamed to `#on_read`.
  * User is responsible for calling `#read` or `#_read` as needed.
  * Callbacks are not protected by a mutex, since no threading.


