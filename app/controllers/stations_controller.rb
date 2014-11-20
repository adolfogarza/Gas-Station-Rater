class StationsController < ApplicationController
  
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :verify_session
  before_action :correct_user, only: [:new, :edit, :update, :destroy]

  def index
    @stations = Station.all
    if params[:search]
      @stations = Station.search(params[:search]).order("created_at DESC")
    else
      @stations = Station.all.order('created_at DESC')
    end
  end

  def show
    @comment=Comment.new
    @pagecomments = @station.comments.order("created_at DESC").page(params[:page]).per(5)
    @coordinates = Gmaps4rails.build_markers(@station) do |station, marker| #metodo de la gema que traduce las coordenadas a codigo de jquery.
      marker.lat station.location.latitude
      marker.lng station.location.longitude
    end

    respond_to do |format|
      format.html
      format.pdf do            
        render  :pdf => "file.pdf", :template => 'stations/pdf_format.html.erb', :javascript_delay => 3000, :disable_javascript   => false
      end
    end    
  end

  def new
    @station = Station.new
    @station.build_location # Esta linea de codigo permite que se cree la clave foranea con el id de la estacion en la tabla de locations.
  end


  def edit
  end

  def create
    @station = Station.new(station_params)
    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'La estacion ha sido creada con exito.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @current_location_value = Location.find_by_station_id(@station.id).id
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: 'La estacion ha sido correctamente actualizada.' }
        format.json { render :show, status: :ok, location: @station }
        Location.find_by_id(@current_location_value).destroy
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @station.destroy
    Location.find_by_station_id(@station.id).destroy
    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'La estacion ha sido destruida.' }
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

    def set_station
      @station = Station.find(params[:id])
    end

    def station_params
      params.require(:station).permit(:legal_name, :counter_honesty, :counter_speed_service, :counter_customer_service, :counter_comments, location_attributes:[:address])
    end
end
