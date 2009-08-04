module Observational
  module Observable
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

    module ClassMethods
      def observers
        @observers ||= []
      end

      def add_observer(observer)
        observers << observer
      end

      def observed_by?(observer)
        observers.include?(observer)
      end

      def observers_for(action)
        observers.select { |o| o.observes_action?(action) }
      end
    end

    protected
      def notify_observers(action)
        self.class.observers_for(action).each { |o| o.invoke(self) }
      end
  end
end

