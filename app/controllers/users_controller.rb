class UsersController < ApplicationController
	def new

	  @user = User.new
		if current_user
	  		redirect_to root_url, :notice => "Ya registraste una cuenta!"
		end
	end

	def create
	  @user = User.new(user_params) #me va a crear una nueva fila en la tabla users, con los valores name, email y password, permitiendole al usuario solo alterar estos.
	  if @user.save
	    redirect_to root_url, :notice => "Felicidades, acabas de crear tu cuenta!, Ahora inicia sesión."
	  else
	    render "new"
	  end
	end

	def user_params
    	params.require(:user).permit(:name, :email, :password, :lastname)
    end
end