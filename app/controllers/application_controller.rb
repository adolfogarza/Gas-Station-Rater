class ApplicationController < ActionController::Base
	
  protect_from_forgery with: :exception
  helper_method :current_user

	private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id] #metodo que me ayuda a determinar cual sesion esta online actualmente.
	end
end