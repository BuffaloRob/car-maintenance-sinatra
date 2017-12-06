class MaintenanceItem < ActiveRecord::Base
  has_many :car_maintenance_items
  has_many :cars, :through => :car_maintenance_items
  belongs_to :user
end

