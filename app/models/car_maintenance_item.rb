class CarMaintenanceItem < ActiveRecord::Base
  belongs_to :car
  belongs_to :maintenance_item

  validates :mileage_performed, :numericality => {:only_integer => true}
  
end