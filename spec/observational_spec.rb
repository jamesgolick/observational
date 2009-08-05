require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Observed; end

describe "Observational" do
  after { Observed.delete_observers }

  describe "declaring an observer" do
    before do
      @observing_klass = Class.new do
        observes :observed, :on      => :some_action,
                            :invokes => :do_stuff
      end

      @observer = Observed.observers.first
    end

    it "should set the observing class as the subscriber" do
      @observer.subscriber.should == @observing_klass
    end

    it "should set the action to the value of the :on parameter" do
      @observer.actions.should == [:some_action]
    end

    it "should set the method to the value of the :invokes parameter" do
      @observer.method.should == :do_stuff
    end

    it "should raise ArgumentError if passed any unfamiliar keys" do
      lambda { Class.new.observes :user, :asdf => "whatever" }.should raise_error(ArgumentError)
    end
  end

  describe "using the activerecord shortcut :before => :whatever" do
    before do
      @observing_klass = Class.new do
        observes :observed, :before  => :create,
                            :invokes => :do_stuff
      end

      @observer = Observed.observers.first
    end

    it "should create an observer with :method => :before_create" do
      @observer.actions.should == [:before_create]
    end
  end
end
