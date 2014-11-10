class Station < ActiveRecord::Base
	#associations
	has_many :comments # define que es el lado muchos de la relacion entre comentarios y estaciones.
	has_one :location # define que tiene una locacion solamente.
	accepts_nested_attributes_for :location # Permite que se guarden atributos de otros modelos en las vistas del modelo estacion.

	#validations
	validates :legal_name, presence: true, length: { in: 4..35 }, uniqueness: true
	
end