class Comment < ActiveRecord::Base
		belongs_to :user
		belongs_to :station
		has_one :rating
		accepts_nested_attributes_for :rating # Permite que se guarden atributos de otros modelos en las vistas del modelo comentario.

		validates_presence_of :title
		validates_presence_of :description
end
