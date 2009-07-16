require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observational" do
  before do
    @user = User.new
  end

  describe "creating an observer on create" do
    it "should invoke that method on create of the observed object" do
      Notifier.expects(:deliver_new_user).with(@user)
      @user.save
    end
  end

  describe "an observer that returns specific data from the observed object" do
    it "should pass that specific data to the observer method" do
      @user.save
      @message = Message.new :creator => @user
      Creditor.expects(:use_credits).with(@user)
      @message.save
    end
  end

  it "should raise ArgumentError if passed any unfamiliar keys" do
    lambda { Class.new.observes :user, :asdf => "whatever" }.should raise_error(ArgumentError)
  end
end
