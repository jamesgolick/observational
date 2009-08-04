require 'observational/observer'

module Observational
  def observes(model_name, opts = {})
    opts.assert_valid_keys :with, :invokes, :on

    model_klass = model_name.to_s.classify.constantize
    observer    = Observer.new :method     => opts[:invokes],
                               :parameters => opts[:with].nil? ? nil : [*opts[:with]],
                               :subscriber => self
    model_klass.send(:"after_#{opts[:on]}") do |object|
      observer.invoke(object)
    end
  end
end

Class.send(:include, Observational) unless Class.include?(Observational)

