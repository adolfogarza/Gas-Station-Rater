class Comment < ActiveRecord::Base
	#associations
	belongs_to :user
	belongs_to :station
	has_one :rating
	accepts_nested_attributes_for :rating # Permite que se guarden atributos de otros modelos en las vistas del modelo comentario.
	
	#validations
	validates :title, :description, presence: true

	#scopes
	scope :select_comment, ->{ select "id" }
	scope :filter_by_station, ->(values){ where(station_id: values) }

	#methods
	def self.find_by_station(station_id)
		select_comment.filter_by_station(station_id)
	end
end