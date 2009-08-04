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
                                            :subscriber => stub(:do_stuff => "")
  end

  it "should accept new observers" do
    @klass.add_observer @observer
    @klass.should be_observed_by(@observer)
  end

  it { @klass.should_not be_observed_by(:non_observer) }
end
