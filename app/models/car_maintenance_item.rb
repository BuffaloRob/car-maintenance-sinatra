class CarMaintenanceItem < ActiveRecord::Base
  belongs_to :car
  belongs_to :maintenance_item
  
end