class MaintenanceItem < ActiveRecord::Base
  has_many :cars, :through => :car_maintenance_items
  belongs_to :user, :through => :cars
  
end