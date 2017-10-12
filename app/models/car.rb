class Car < ActiveRecord::Base
	belongs_to :user
	has_many :maintenances, :through => :car_maintenances
 
end