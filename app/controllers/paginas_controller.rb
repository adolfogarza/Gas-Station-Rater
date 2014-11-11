class PaginasController < ApplicationController


  def principal
  	@user=User.new
  	@comments = Comment.all.page(params[:page]).per(10)
  end
end