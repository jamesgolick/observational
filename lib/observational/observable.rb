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
    end
  end
end

