#
# Copied from main gem, except:
#  Added :output_open_drain mode
#
module Denko
  module Behaviors
    module OutputPin
      include SinglePin
      
      def initialize_pins(options={})
        super(options)
        
        # Assume output direction, and look for open-drain in options.
        initial_mode = :output
        initial_mode = :output_open_drain if options[:open_drain]

        # If user was explicit about mode, just use that.
        initial_mode = options[:mode]  if options[:mode]
        
        self.mode = initial_mode
      end
    end
  end
end
