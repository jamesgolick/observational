module Observational
  module ActiveRecordObservers
    def self.included(klass)
      ActiveRecord::Callbacks::CALLBACKS.each do |callback|
        klass.send(callback) { |obj| obj.send :notify_observers, callback }
      end
      klass.class_eval do
        extend ClassMethods
        class << self
          alias_method_chain :define_callbacks, :observational
        end
      end
    end

    module ClassMethods
      def define_callbacks_with_observational(*callbacks)
        define_callbacks_without_observational *callbacks
        callbacks.each do |c|
          send(c) { |obj| obj.send :notify_observers, c }
        end
      end
    end
  end
end

