class User < ActiveRecord::Base
  has_secure_password
  has_many :cars
  has_many :maintenance_items

  validates :username, uniqueness: true#, message: "Please choose a different name"
  validates :email, uniqueness: true#, message: "That email is already being used"

  include Slug::InstanceMethods
  extend Slug::ClassMethods

end