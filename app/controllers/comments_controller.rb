class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :verify_session
  before_action :correct_user, only: [:edit, :update, :destroy, :index]

  def index
    @comments = Comment.all.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"comments-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end 
  end

  def show
  end

  #def new
    #@comment = current_user.comments.build
  #end

  def edit
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if not Station.find(@comment.station_id).nil?
      respond_to do |format|
        @station = Station.find_by_id(@comment.station_id)
        if @comment.save
          if @station.counter_honesty.nil?
            @station.counter_honesty = @comment.rating.honesty
          else
            @station.counter_honesty += @comment.rating.honesty
          end
          if @station.counter_customer_service.nil?
            @station.counter_customer_service = @comment.rating.customer_service
          else
            @station.counter_customer_service += @comment.rating.customer_service
          end
          if @station.counter_speed_service.nil?
            @station.counter_speed_service = @comment.rating.speed_service
          else
            @station.counter_speed_service += @comment.rating.speed_service
          end  
          if @station.counter_comments.nil?
            @station.counter_comments = 1
          else
            @station.counter_comments += 1
          end  
          @station.save
          format.html { redirect_to @station, notice: 'Tu comentario ha sido creado con exito!' }
          format.json { render :show, status: :created, location: @comment }          
        else
          format.html { redirect_to @station, notice: 'Tu comentario esta incompleto' }
        end
      end
    end
  end

  def update

    if @comment.station

      @station = Station.find_by_id(@comment.station_id)
      unless @station.counter_honesty.nil?
        @station.counter_honesty -= @comment.rating.honesty      
      end
      unless @station.counter_customer_service.nil?
        @station.counter_customer_service -= @comment.rating.customer_service      
      end
      unless @station.counter_speed_service.nil?
        @station.counter_speed_service -= @comment.rating.speed_service      
      end
      unless @station.counter_comments.nil?
        @station.counter_comments -= 1      
      end 
      @station.save 

    end 

    @current_rating_id = Rating.find_by_comment_id(@comment.id).id
    respond_to do |format|
      if @comment.update(comment_params)


          if @station.counter_honesty.nil?
            @station.counter_honesty = @comment.rating.honesty
          else
            @station.counter_honesty += @comment.rating.honesty
          end
          if @station.counter_customer_service.nil?
            @station.counter_customer_service = @comment.rating.customer_service
          else
            @station.counter_customer_service += @comment.rating.customer_service
          end
          if @station.counter_speed_service.nil?
            @station.counter_speed_service = @comment.rating.speed_service
          else
            @station.counter_speed_service += @comment.rating.speed_service
          end  
          if @station.counter_comments.nil?
            @station.counter_comments = 1
          else
            @station.counter_comments += 1
          end  
          @station.save


        format.html { redirect_to @comment, notice: 'El comentario ha sido actualizado con exito' }
        format.json { render :show, status: :ok, location: @comment }
        Rating.find_by_id(@current_rating_id).destroy
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    if @comment.station
      @station = Station.find_by_id(@comment.station_id)
      unless @station.counter_honesty.nil?
        @station.counter_honesty -= @comment.rating.honesty      
      end
      unless @station.counter_customer_service.nil?
        @station.counter_customer_service -= @comment.rating.customer_service      
      end
      unless @station.counter_speed_service.nil?
        @station.counter_speed_service -= @comment.rating.speed_service      
      end
      unless @station.counter_comments.nil?
        @station.counter_comments -= 1      
      end 
      @station.save 
    end  

    @comment.destroy
    Rating.find_by_comment_id(@comment.id).destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'El comentario ha sido borrado.' }
      format.json { head :no_content }
    end
  end

  def verify_session
    if current_user.nil?
      redirect_to log_in_url, :notice => "Debes iniciar sesion."
    end
  end

  def correct_user
    if current_user.privileges == 0
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url, notice: "No estas autorizado para modificar este comentario." if @comment.nil?
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:title, :description, :station_id, rating_attributes:[:honesty, :speed_service, :customer_service])
    end
end
