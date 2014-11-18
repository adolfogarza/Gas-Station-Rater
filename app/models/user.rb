class User < ActiveRecord::Base  
  #associations
  has_many :comments

  #virtual variables
  attr_accessor :password

  #callbacks
  before_save :encrypt_password #antes de guardar el usuario a la base de datos, ejecuta el metodo encrypt_password.
  before_save :asign_priority #antes de guardar el usuario, se le asigna una prioridad de 0, para poder diferenciar entre usuarios administradores y usuarios normales.

  #validations
  validates :name, :lastname, presence: true
  validates_presence_of :password, :on => :create
  validates :email, presence: true, uniqueness: true

  #methods 
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password #la gema Bcrypt me define la variable password_hash con una salt para brindar mayor seguridad.
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def asign_priority 
    if self.privileges.nil?
      self.privileges = 0
    end
  end
end