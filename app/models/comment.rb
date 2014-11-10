class Comment < ActiveRecord::Base
		#associations
		belongs_to :user
		belongs_to :station
		has_one :rating
		accepts_nested_attributes_for :rating # Permite que se guarden atributos de otros modelos en las vistas del modelo comentario.
		
		#validations
		validates :title, :description, presence: true
end