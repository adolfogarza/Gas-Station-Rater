class Station < ActiveRecord::Base

	has_many :comments # define que es el lado muchos de la relacion entre comentarios y estaciones.
	has_one :location # define que tiene una locacion solamente.
	accepts_nested_attributes_for :location # Permite que se guarden atributos de otros modelos en las vistas del modelo estacion.

	validates_presence_of :legal_name


end
