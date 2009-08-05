module Observational
  module ActiveRecordObservers
    def self.included(klass)
      ActiveRecord::Callbacks::CALLBACKS.each do |callback|
        klass.send(callback) { |obj| obj.send :notify_observers, callback }
      end
    end
  end
end

