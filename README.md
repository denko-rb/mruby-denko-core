# mruby-denko-core

Core Denko functionality for mruby.

Implements the `Denko` modules/classes listed below, with interfaces as close to the [CRuby gem](https://github.com/denko-rb/denko) as possible.

- `Version`
- `Behaviors`
  - `State`
  - `Component`
  - `Callbacks`
  - `Reader`
  - `SinglePin`
  - `InputPin`
  - `OutputPin`
  - `MultiPin`
- `DigitalIO`
  - `Input`
  - `Output`
- `AnalogIO`
  - `Input`
  - `Output`
- `PulseIO`
  - `PWMOutput`
- `LED`
  - `Base` (`LED#new` aliases to `LED::Base.new` like CRuby)
  - `RGB`
- `Motor`
  - `L298` (or other full bridge driver with same interface)
  - `Stepper` (EasyDriver or compatible interface)

## Usage

See [mruby-denko](https://github.com/denko-rb/mruby-denko) for templates.

## Limitations & Differences (vs. CRuby)

- No multithreading, so no polling or listening in a separate thread.
- No mutexes
- `Component#new` will default to `$board` when `board:` argument not given.

## Dependencies

This gem is pure mruby, and requires a compatible mruby implementation of `Denko::Board` for your microcontroller. Currently the only implementation is for the ESP32, [mruby-denko-board-esp32](https://github.com/denko-rb/mruby-denko-board-esp32).

This gem also specifies many mruby dependencies, needed to get similar functionality to CRuby. They will automatically be included in the build. See `mrbgem.rake`.
