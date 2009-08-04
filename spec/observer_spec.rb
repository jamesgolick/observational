require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observer" do
  before do
    @klass    = Class.new
    @observer = Observational::Observer.new :subscriber => @klass, 
                                            :method     => :do_stuff
  end

  it "should invoke the :method with the object" do
    @klass.expects(:do_stuff).with(:the_object)
    @observer.invoke(:the_object)
  end
end

