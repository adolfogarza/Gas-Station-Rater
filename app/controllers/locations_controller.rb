class LocationsController < ApplicationController

  before_action :set_location, only: [:update, :destroy]
  before_action :verify_session
  before_action :correct_user, only: [:update, :destroy]

  #def index
  #  @locations = Location.all
  #end

  #def new
  #  @location = Location.new
  #end

  #def edit
  #end

  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
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
      redirect_to root_url, notice: "No estas autorizado" if @comment.nil?
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:address, :longitude, :latitude)
  end  
end