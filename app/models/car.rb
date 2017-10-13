class Car < ActiveRecord::Base
	belongs_to :user
	has_many :maintenance_items, :through => :car_maintenance_items
 
end