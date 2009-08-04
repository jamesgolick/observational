require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observable" do
  before do
    @klass = Class.new do
      include Observational::Observable

      def save
        fire_observers :after_create
      end
    end
    @observer = Observational::Observer.new :method     => :do_stuff,
                                            :subscriber => stub(:do_stuff => ""),
                                            :actions    => :some_action
  end

  it "should accept new observers" do
    @klass.add_observer @observer
    @klass.should be_observed_by(@observer)
  end

  it { @klass.should_not be_observed_by(:non_observer) }

  describe "notifying observers" do
    before do
      @observable = @klass.new
      @klass.add_observer @observer
      @different_action = Observational::Observer.new :method     => :do_stuff,
                                                      :subscriber => stub(:do_stuff => ""),
                                                      :actions    => :something_else
      @klass.add_observer @different_action
    end

    it "should notify the observers who are interested" do
      @observer.expects(:invoke).with(@observable)
      @different_action.expects(:invoke).never
      @observable.send :notify_observers, :some_action
    end
  end
end
