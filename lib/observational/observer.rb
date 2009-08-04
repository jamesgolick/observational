module Observational
  class Observer
    attr_reader :subscriber, :method

    def initialize(options)
      @subscriber = options[:subscriber]
      @method     = options[:method]
    end

    def invoke(observable)
      @subscriber.send(method, observable)
    end
  end
end

