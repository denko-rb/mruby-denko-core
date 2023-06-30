require_relative "mrblib/denko/version"

MRuby::Gem::Specification.new('mruby-denko-core') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = Denko::VERSION
  
  # Core dependencies.
  spec.add_dependency('mruby-method')
  
  spec.add_dependency('mruby-array-ext')
  spec.add_dependency('mruby-bigint')
  spec.add_dependency('mruby-class-ext')
  spec.add_dependency('mruby-compar-ext')
  spec.add_dependency('mruby-compiler')
  spec.add_dependency('mruby-enum-chain')
  spec.add_dependency('mruby-enum-ext')
  spec.add_dependency('mruby-enumerator')
  spec.add_dependency('mruby-errno')
  spec.add_dependency('mruby-eval')
  spec.add_dependency('mruby-hash-ext')
  spec.add_dependency('mruby-metaprog')
  spec.add_dependency('mruby-object-ext')
  spec.add_dependency('mruby-objectspace')
  spec.add_dependency('mruby-print')
  spec.add_dependency('mruby-range-ext')
  spec.add_dependency('mruby-set')
  spec.add_dependency('mruby-string-ext')
  spec.add_dependency('mruby-struct')
  spec.add_dependency('mruby-symbol-ext')
  spec.add_dependency('mruby-toplevel-ext')
  
  # Include files in the right order.
  spec.rbfiles = [
    "#{dir}/mrblib/denko/version.rb",
    
    # Behaviors
    "#{dir}/mrblib/denko/behaviors/state.rb",
    "#{dir}/mrblib/denko/behaviors/callbacks.rb",
    "#{dir}/mrblib/denko/behaviors/component.rb",
    "#{dir}/mrblib/denko/behaviors/reader.rb",
    "#{dir}/mrblib/denko/behaviors/single_pin.rb",
    "#{dir}/mrblib/denko/behaviors/multi_pin.rb",
    "#{dir}/mrblib/denko/behaviors/input_pin.rb",
    "#{dir}/mrblib/denko/behaviors/output_pin.rb",
    
    # DigitalIO
    "#{dir}/mrblib/denko/digital_io/input.rb",
    "#{dir}/mrblib/denko/digital_io/output.rb",
    
    # AnalogIO
    "#{dir}/mrblib/denko/analog_io/input.rb",
    "#{dir}/mrblib/denko/analog_io/output.rb",
    
    # PulseIO
    "#{dir}/mrblib/denko/pulse_io/pwm_output.rb",
    
    # LED
    "#{dir}/mrblib/denko/led/base.rb",
    "#{dir}/mrblib/denko/led/rgb.rb",
    
    # Motor
    "#{dir}/mrblib/denko/motor/l298.rb",
    "#{dir}/mrblib/denko/motor/stepper.rb",
  ]
end
