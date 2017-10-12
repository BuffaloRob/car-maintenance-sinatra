class Maintenance < ActiveRecord::Base
  has_many :cars, :through => :car_maintenances
  belongs_to :user, :through => :cars
  
end