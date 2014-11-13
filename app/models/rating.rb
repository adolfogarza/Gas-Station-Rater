class Rating < ActiveRecord::Base
	#associations
	belongs_to :comment

	#validations
	validates :honesty, :speed_service, :customer_service, presence: true, length: { in: 1..5 }

	#scopes
	scope :select_rating, ->{ select("ratings.id, ratings.honesty, ratings.updated_at, ratings.created_at, ratings.customer_service, ratings.speed_service") }
	scope :filter_by_comment, ->(values){ where(comment_id: values) }

	def self.get_station_ratings(station_id)
		comments = Comment.find_by_station(station_id)
		select_rating.filter_by_comment(comments)
	end
end