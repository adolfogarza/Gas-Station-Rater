class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :verify_session, except: [:index, :show] #verifica que haya una sesion online antes que alguien pueda crear un comentario hacia una estacion.
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show

  end

  # GET /comments/new
  def new
  @comment = current_user.comments.build

  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create

    @comment = current_user.comments.build(comment_params)

    if not Station.find(@comment.station_id).nil?

      respond_to do |format|
        @station = Station.find_by_id(@comment.station_id)
        if @comment.save
          format.html { redirect_to @station, notice: 'Tu comentario ha sido creado con exito!' }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @current_comment_value = Rating.find_by_comment_id(@comment.id).id
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'El comentario ha sido actualizado con exito!' }
        format.json { render :show, status: :ok, location: @comment }
        Rating.find_by_comment_id(@current_comment_value).destroy
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    Rating.find_by_comment_id(@comment.id).destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'El comentario ha sido borrado con exito' }
      format.json { head :no_content }
    end
  end

  def verify_session

    if current_user.nil?
      redirect_to log_in_url, :notice => "Debes iniciar sesion"
  end
end

def correct_user
    if current_user.privileges == 0
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url, notice: "No estas autorizado para modificar este comentario!" if @comment.nil?
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :description, :station_id, rating_attributes:[:honesty, :speed_service, :customer_service])
    end
end
