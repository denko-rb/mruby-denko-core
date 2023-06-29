# mruby-denko-core

Core Denko functionality for mruby. Goal is to implement these `Denko` modules/classes, with interfaces as close to the CRuby gem as possible: 

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

This gem also specifies mruby gem dependencies, as needed to achieve similar functionality to the CRuby gem. See `mrbgem.rake` for a full list.
