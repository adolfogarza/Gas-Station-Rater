class Rating < ActiveRecord::Base
	belongs_to :comment

		validates_presence_of :honesty
		validates_presence_of :speed_service
		validates_presence_of :customer_service
end
