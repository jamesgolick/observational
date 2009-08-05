require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observational::ActiveRecord" do
  include Observational

  before do
    @user = User.new
  end

  [:before_create, :after_create, :before_save, :after_save].each do |callback|
    describe "observing #{callback}" do
      it "should fire the observer during that callback" do
        self.expects(:subscription).with(@user)
        observes :user, :invokes => :subscription, :on => callback
        @user.send :callback, callback
      end
    end
  end
end
