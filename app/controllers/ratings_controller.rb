class RatingsController < ApplicationController

  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :verify_session
  before_action :correct_user, only: [:update, :destroy]


  #def index
  #  @ratings = Rating.all
  #end

  #def show
  #end

  #def new
  #  @rating = Rating.new
  #end

  #def edit
  #end

  def create
    @rating = Rating.new(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
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
      redirect_to root_url, notice: "No estas autorizado." if @comment.nil?
    end
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:honesty, :speed_service, :customer_service)
  end
  
end
