require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'observational'
require 'activerecord'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string  :email,    :default => ''
  end

  create_table :messages do |t|
    t.integer :creator_id
    t.string  :email,    :default => ''
  end
end

class User < ActiveRecord::Base
end

class Message < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
end

class Notifier
  observes :user, :invokes => :deliver_new_user, :on => :after_create

  def self.deliver_new_user(user)
  end
end

class Creditor
  observes :message, :invokes => :use_credits, :with => :creator, :on => :create

  def self.use_credits(user)
  end
end

require 'observational/active_record'
ActiveRecord::Base.send(:include, Observational::ActiveRecordObservers)

