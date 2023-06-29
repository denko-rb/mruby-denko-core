module Denko
  module MultiPin
    #
    # Model complex components, using multiple pins, by using proxy components
    # with one pin each. 
    #
    include Component
    attr_accessor :pins, :proxies
  
    def proxy_states
      hash = Hash.new
      proxies.each_key do |key|
        hash[key] = self.proxies[key].state
      end
      return hash
    end

    def before_initialize(options={})
      # Get given pins early. Avoids giving them again to require or proxy.
      self.pins = options[:pins]
      self.proxies = {}
      super(options)
    end
  
    #
    # Proxy a pin to a single-pin component. Set this up in the including
    # component's #initialize_pins method. Additional options for each proxy
    # (eg. pullup/pulldown) can be injected there.
    # 
    def proxy_pin(name, klass, pin_options={})
      # Proxied pins are required by default.
      require_pin(name) unless pin_options[:optional]
    
      # Make the proxy if the pin was given.
      if self.pins[name]      
        proxy = klass.new pin_options.merge(pin: self.pins[name])
        # Overwrite given pin with mapped pin that proxy got from the board.
        self.pins[name] = proxy.pin
        self.proxies[name] = proxy
        instance_variable_set("@#{name}", proxy)
      end

      # Accessor for the proxy, or nil if not given, and not required.
      singleton_class.class_eval { attr_reader name }
    end
  
    #
    # Require a single pin that may or may not be proxied.
    #
    def require_pin(name)
      raise ArgumentError, "missing :#{name} pin" unless self.pins[name]
    end

    def require_pins(*array)
      [array].flatten.each { |name| require_pin(name) }
    end
  end
end
