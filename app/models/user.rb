class User < ActiveRecord::Base
  has_secure_password
  has_many :cars
  has_many :maintenance_items, :through => :cars
 
end