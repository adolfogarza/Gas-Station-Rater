class SessionsController < ApplicationController
  
  def new
    if current_user
      redirect_to root_url, :notice => "Ya iniciaste sesion!"
    end
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Iniciaste sesión correctamente"
    else
      flash.now.alert = "Los datos ingresados son incorrectos!"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Cerraste tu sesión correctamente"
  end
end