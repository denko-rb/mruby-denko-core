#
# Copied from main gem except:
#   No protected
#   Board#register doesn't exist, so no #register, #unregister
#   Uses $board if no board given in options.
#   Board#micro_delay not implemented yet.
#
module Denko
  module Behaviors
    module Component
      include State
      attr_reader :board
  
      def initialize(options={})
        super(options)
        before_initialize(options)
        initialize_board(options)
        convert_pins(options)
        initialize_pins(options)
        # register
        after_initialize(options)
      end
      
      def micro_delay(duration)
        # board.micro_delay(duration)
      end
  
      def initialize_board(options={})
        raise ArgumentError, 'a board is required for a component' unless options[:board]
        @board = options[:board] || $board
      end
  
      # Behaviors::Component only requires a board.
      # Include modules from Setup or override this to use pins.
      #
      def before_initialize(options={}); end
      def convert_pins(options={});      end
      def initialize_pins(options={});   end
      alias :initialize_pin :initialize_pins

      # Override in components. Call super when inheriting or mixing in.
      def after_initialize(options={}); end
    end
  end
end
