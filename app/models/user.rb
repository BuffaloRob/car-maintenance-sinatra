class User < ActiveRecord::Base
  has_many :cars
  has_many :maintenances, :through => :cars
 
end