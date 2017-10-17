class User < ActiveRecord::Base
  has_secure_password
  has_many :cars
  include Slug::InstanceMethods
  extend Slug::ClassMethods

end