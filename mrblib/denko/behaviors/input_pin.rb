#
# Copied from main gem, except:
#  No listeners
#  Added :input_pullup_pulldown mode
#
module Denko
  module Behaviors
    module InputPin
      include SinglePin
  
      def initialize_pins(options={})
        super(options)
        
        # Assume input direction, and look for pull mode in options.
        initial_mode = :input
        initial_mode = :input_pullup          if options[:pullup]
        initial_mode = :input_pulldown        if options[:pulldown]
        initial_mode = :input_pullup_pulldown if options[:pullup_pulldown]

        # If user was explicit about mode, just use that.
        initial_mode = options[:mode]  if options[:mode]
        
        self.mode = initial_mode
      end
    end
  end
end
