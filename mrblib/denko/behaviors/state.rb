#
# Copied from main gem, except:
#  No Mutex
#
module Denko
  module Behaviors
    module State
      def initialize(options={})
        @state = nil
      end
      
      attr_accessor :state
      
      def update_state(value)
        self.state = value if value
      end
    end
  end
end
