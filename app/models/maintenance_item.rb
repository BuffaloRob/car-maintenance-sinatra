class MaintenanceItem < ActiveRecord::Base
  has_many :cars, :through => :car_maintenance_items
  has_and_belongs_to_many :users
  
end