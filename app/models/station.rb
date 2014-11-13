class Station < ActiveRecord::Base
	#Callbacks
	before_save :asign_defaults

	#Associations
	has_many :comments # define que es el lado muchos de la relacion entre comentarios y estaciones.
	has_one :location # define que tiene una locacion solamente.
	accepts_nested_attributes_for :location # Permite que se guarden atributos de otros modelos en las vistas del modelo estacion.

	#Validations
	validates :legal_name, presence: true, length: { in: 4..55 }, uniqueness: true

	#Methods
	def asign_defaults 
		if self.counter_honesty.nil?
			self.counter_honesty = 0
			self.counter_speed_service = 0
			self.counter_customer_service = 0
			self.counter_comments = 0
		end
	end

	def self.search(query)
	  where("lower(legal_name) like ?", "%#{query.downcase}%") 
	end
end