module Dino
  module Callbacks
    attr_reader :callbacks
  
    def read(*args)
      result = _read(*args)
      filtered_result = update(result)
    end
  
    def after_initialize(options={})
      super(options)
      @callbacks = {}
    end
  
    def add_callback(key=:persistent, &block)
      @callbacks[key] ||= []
      @callbacks[key] << block
    end

    def remove_callback(key=nil)
      key ? @callbacks.delete(key) : @callbacks = {}
    end

    alias :on_read :add_callback
    alias :remove_callbacks :remove_callback

    def update(data)
      filtered_data = pre_callback_filter(data) 
      @callbacks.each_value do |array|
        array.each do |callback|
          callback.call(filtered_data)
        end
      end
      update_state(filtered_data)
    end
  
    # Override to process data before giving to callbacks and state.
    def pre_callback_filter(data)
      data
    end

    # Override for behavior other than @state = filtered data.
    def update_state(filtered_data)
      self.state = filtered_data
    end
  end
end
