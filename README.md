# mruby-denko-core

Core Denko functionality for mruby.

Goal is to implement the `Denko` modules/classes below, with interfaces as close to the [CRuby gem](https://github.com/denko-rb/denko) as possible: 

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

This gem also specifies any mruby dependencies requried to get similar functionality to CRuby.

See `mrbgem.rake` for a full list.
