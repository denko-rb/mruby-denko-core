require_relative "mrblib/version"

MRuby::Gem::Specification.new('mruby-dino-core-esp32') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = Dino::VERSION
  
  # Core dependencies.
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
  
  # Dependencies from mruby-esp32 project.
  spec.add_dependency('mruby-esp32-system', github: 'mruby-esp32/mruby-esp32-system')
  spec.add_dependency('mruby-esp32-wifi',   github: 'mruby-esp32/mruby-esp32-wifi')
  spec.add_dependency('mruby-esp32-mqtt',   github: 'mruby-esp32/mruby-esp32-mqtt')
  spec.add_dependency('mruby-esp32-gpio',   github: 'mruby-esp32/mruby-esp32-gpio')
  spec.add_dependency('mruby-io',           github: 'mruby-esp32/mruby-io', :branch => 'esp32')
  
  # Include files in the right order.
  spec.rbfiles = [
    "#{dir}/mrblib/version.rb",
    "#{dir}/mrblib/pins.rb",
    "#{dir}/mrblib/pin_base.rb",
    "#{dir}/mrblib/pin_single_pin.rb",
    "#{dir}/mrblib/pin_digital.rb",
    "#{dir}/mrblib/pin_analog_input.rb",
    "#{dir}/mrblib/pin_pwm_output.rb",
    "#{dir}/mrblib/pin_dac_output.rb",
    "#{dir}/mrblib/pin_multi_pin.rb",
  ]
end