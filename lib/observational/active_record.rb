module Observational
  module ActiveRecordObservers
    def self.included(klass)
      [:after_create, :before_create, :before_save, :after_save].each do |callback|
        klass.send(callback) { |obj| obj.send :notify_observers, callback }
      end
    end
  end
end

