#
# Copied form CRuby gem, except:
#   No #blink since no Behaviors::Threaded
#
module Denko
  module LED
    class Base < PulseIO::PWMOutput
    end
    
    def self.new(options={})
      self::Base.new(options)
    end
  end
end
