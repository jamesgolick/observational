require 'observational/observer'
require 'observational/observable'

module Observational
  ##
  # Declares an observer
  #
  # @param [Symbol] the name of the model to observe
  # @param [Hash] opts observer options
  # @option opts [Symbol] :invokes The method to invoke on the subscriber.
  # @option opts [Symbol] :with The parameters to pass to the method that gets invoked.
  # @option opts [Symbol] :on The action to observe. e.g. :after_create for an active_record object
  # @option opts [Symbol] :after A shortcut for AR objects. :after => :create is the equivalent of :on => :after_create
  # @option opts [Symbol] :before Same as :after
  #
  def observes(model_name, opts = {})
    opts.assert_valid_keys :with, :invokes, :on, :before, :after

    opts[:on]   = :"before_#{opts[:before]}" unless opts[:before].nil?
    opts[:on]   = :"after_#{opts[:after]}" unless opts[:after].nil?
    model_klass = model_name.to_s.classify.constantize
    model_klass.send(:include, Observable) unless model_klass.include?(Observable)
    observer    = Observational::Observer.new :method     => opts[:invokes],
                                              :parameters => opts[:with].nil? ? nil : [*opts[:with]],
                                              :subscriber => self,
                                              :actions    => opts[:on]
    model_klass.add_observer(observer)
  end
end

Class.send(:include, Observational) unless Class.include?(Observational)

