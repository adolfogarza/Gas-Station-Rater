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

  def edit
     @user = current_user
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to root_url, notice: 'Los datos de usuario han sido actualizados.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    current_user.destroy
    respond_to do |format|
      format.html { redirect_to log_out_url, notice: 'La cuenta ha sido correctamente borrada.' }
      format.json { head :no_content }
    end
  end
  
	def user_params
    	params.require(:user).permit(:name, :email, :password, :lastname)
    end
end