require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observational::ActiveRecord" do
  include Observational

  before do
    @user = User.new
  end

  ActiveRecord::Callbacks::CALLBACKS.each do |callback|
    describe "observing #{callback}" do
      it "should fire the observer during that callback" do
        self.expects(:subscription).with(@user)
        observes :user, :invokes => :subscription, :on => callback
        @user.send :callback, callback
      end
    end
  end

  describe "adding custom callbacks" do
    before do
      User.send :define_callbacks, :after_something_else
      self.expects(:subscription).with(@user)
      observes :user, :invokes => :subscription, :after => :something_else
    end

    it "should make it possible to observe those using observational" do
      @user.send :callback, :after_something_else
    end
  end
end
