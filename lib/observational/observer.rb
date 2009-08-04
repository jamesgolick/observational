module Observational
  class Observer
    attr_reader :subscriber, :method, :parameters

    def initialize(options)
      @subscriber = options[:subscriber]
      @method     = options[:method]
      @parameters = options[:parameters]
    end

    def invoke(observable)
      @subscriber.send(method, *arguments(observable))
    end

    protected
      def arguments(observable)
        parameters.nil? ? observable : parameters.map { |p| observable.send(p) }
      end
  end
end

