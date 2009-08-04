require 'observational/observer'
require 'observational/observable'

module Observational
  def observes(model_name, opts = {})
    opts.assert_valid_keys :with, :invokes, :on

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

