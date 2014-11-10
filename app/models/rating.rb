class Rating < ActiveRecord::Base
	#associations
	belongs_to :comment

	#validations
	validates :honesty, :speed_service, :customer_service, presence: true, length: { in: 1..5 }
end