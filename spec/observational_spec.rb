require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observational" do
  describe "creating an observer on create" do
    it "should invoke that method on create of the observed object" do
      @user = User.new
      Notifier.expects(:deliver_new_user).with(@user)
      @user.save
    end
  end
end
