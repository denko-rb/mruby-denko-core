# mruby-dino-core-esp32

mruby implementation of the core [dino](https://github.com/austinbv/dino) features, running directly on the ESP32 chip. Depends on [mruby-esp32](https://github.com/mruby-esp32).


### Core Features Not Implemented Yet

* PWM output
* Callbacks


### Key Differences

* Low-level components are inside `Pins`, rather than `Dino::Components::Basic` or `Dino::Components::Setup`.
* Higher level components will go in the top level namespace, not `Dino::Components`.
* The `Dino` module isn't really used, expect to set the version number.
* There is no `Board` class, or `board:` requirement to initialize a component. Might need as an option for registers later.
* `Component#state` is not protected by a mutex, since it doesn't work, and there's only one thread.
* Components do not implement `_read`, `_poll` or `_listen`. The user must call `component#read` somewhere in their loop. Callbacks will trigger when this is done though.
* Components do not implement `Dino::Mixins::Threaded` for doing "background" tasks like `Led#blink`, since there is only one thread.

* `DigitalOutput` and `DigitalInput` components are both replaced by `Pins::Digital`, which can act as both.
* The `AnalogOutput` class is replaced by `Pins::DACOutput` and `Pins::PWMOutput`, for DAC and PWM output respectively.
* The `pullup:` and `pulldown:` options will do nothing when initializing a component. The ESP32 handles that within pin mode setting. Use `component#mode=` instead. The valid modes are:
   * `:input`
   * `:input_pullup`
   * `:input_pulldown`
   * `:input_output`
   * `:output`
* Will add a `mode:` option to the single pin initilization hash too.
