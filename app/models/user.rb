class User < ActiveRecord::Base
  has_secure_password
  has_many :cars
  has_many :maintenances, :through => :cars
 
end