class CarMaintenance < ActiveRecord::Base
  belongs_to :car
  belongs_to :maintenance
  
end