module Observational
  class Observer
    attr_reader :subscriber, :method, :parameters, :actions

    def initialize(options)
      @subscriber = options[:subscriber]
      @method     = options[:method]
      @parameters = options[:parameters]
      @actions    = [*options[:actions]]
    end

    def invoke(observable)
      @subscriber.send(method, *arguments(observable))
    end

    def observes_action?(action)
      actions.include?(action)
    end

    protected
      def arguments(observable)
        parameters.nil? ? observable : parameters.map { |p| observable.send(p) }
      end
  end
end

