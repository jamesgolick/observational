module Observational
  def observes(model_name, opts = {})
    model_klass    = model_name.to_s.classify.constantize
    observer_klass = self
    model_klass.send(:"after_#{opts[:on]}") do |object|
      argument = opts.has_key?(:with) ? object.send(opts[:with]) : object
      observer_klass.send(opts[:invokes], argument)
    end
  end
end

Class.send(:include, Observational) unless Class.include?(Observational)

