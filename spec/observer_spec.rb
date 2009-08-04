require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observer" do
  before do
    @klass    = Class.new
  end

  describe "without paraemeters specified" do
    before do
      @observer = Observational::Observer.new :subscriber => @klass, 
                                              :method     => :do_stuff
    end

    it "should invoke the :method with the object" do
      @klass.expects(:do_stuff).with(:the_object)
      @observer.invoke(:the_object)
    end
  end

  describe "with particular parameters" do
    before do
      @observer = Observational::Observer.new :subscriber => @klass,
                                              :method     => :do_stuff,
                                              :parameters => [:foo, :bar]
    end
    
    it "should invoke the method with the parameters as specified" do
      @klass.expects(:do_stuff).with("bar", "foo")
      @observer.invoke(stub(:foo => "bar", :bar => "foo"))
    end
  end

  describe "observing :after_create" do
    before do
      @observer = Observational::Observer.new :subscriber => @klass,
                                              :method     => :do_stuff,
                                              :parameters => [:foo, :bar],
                                              :actions    => :after_create
    end
    subject { @observer }

    it { should be_observes_action(:after_create) }
    it { should_not be_observes_action(:other_stuff) }
  end
end

