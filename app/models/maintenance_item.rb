class MaintenanceItem < ActiveRecord::Base
  has_many :cars, :through => :car_maintenance_items
  has_many :users, :through => :cars
  
end