require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Observational::ActiveRecord" do
  include Observational

  def subscriber(user)
    @new_record = user.new_record?
  end

  describe "observing after_create" do
    before do
      observes :user, :on => :after_create, :invokes => :subscriber
      User.create
    end
    after { User.delete_observers }

    it "should fire after the object is created" do
      @new_record.should be_false
    end
  end

  describe "observing before_create" do
    before do
      observes :user, :on => :before_create, :invokes => :subscriber
      User.create
    end
    after { User.delete_observers }

    it "should fire after the object is created" do
      @new_record.should be_true
    end
  end
end
