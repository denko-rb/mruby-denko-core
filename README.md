# mruby-denko-core

Core Denko functionality for mruby, aiming for an interface as close to the [CRuby gem](https://github.com/denko-rb/denko) as possible.

Implements 5 low-level GPIO features:
- Digital Input / Output
- Analog Input / Output
- PWM Ouput

As well as:
- Peripherals which depend on **only** these features
- Shared peripheral functionality, in `Denko::Behaviors`

### Modules/Classes Implemented
- Version
- Behaviors
  - State
  - Component
  - Callbacks
  - Reader
  - SinglePin
  - InputPin
  - OutputPin
  - MultiPin
- DigitalIO
  - Input (only `#read`, no `#poll` or `#listen` yet)
  - Output
- AnalogIO
  - Input (only `#read`, no `#poll` or `#listen` yet)
  - Output
- PulseIO
  - PWMOutput
- LED
  - Base (`LED#new` aliases to `LED::Base.new`)
  - RGB
- Motor
  - L298 (or other full-bridge driver with same interface)
  - Stepper (EasyDriver or other driver with compatible interface)
  
### To Be Implemented
- DigitalIO
  - Button
  - RotaryEncoder
- PulseIO
  - Buzzer
- LED
  - SevenSegment
- Display
  - HD44780
- Motor
  - Servo / ESC

## Usage

See [mruby-denko](https://github.com/denko-rb/mruby-denko) for templates.

## Limitations & Differences (vs. CRuby)

- No multithreading, so no polling or listening in a separate thread.
- No mutexes
- `Component#new` defaults to `$board` if `board:` not given.
- Board gems should define `$board` as an instance after loading.

## Dependencies

This gem is pure mruby, and requires a compatible mruby implementation of `Denko::Board` for your microcontroller. Currently the only implementation is for the ESP32, [mruby-denko-board-esp32](https://github.com/denko-rb/mruby-denko-board-esp32).

This gem also specifies many mruby dependencies, needed to get similar functionality to CRuby. They will automatically be included in the build. See `mrbgem.rake`.
