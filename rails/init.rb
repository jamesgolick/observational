ActiveRecord::Base.send(:include, Observational::ActiveRecordObservers)
ActiveRecord::Base.send(:include, Observational::Observable)
