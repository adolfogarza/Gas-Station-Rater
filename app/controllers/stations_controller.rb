class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :verify_session, except: [:index, :show] #verifica que haya una sesion online antes que alguien pueda crear una estacion.

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    @comment=Comment.new
   
   @coordinates = Gmaps4rails.build_markers(@station) do |station, marker| #metodo de la gema que traduce las coordenadas a codigo de jquery.
      marker.lat station.location.latitude
      marker.lng station.location.longitude
    end

  end

  # GET /stations/new
  def new
    @station = Station.new
    @station.build_location # Esta linea de codigo permite que se cree la clave foranea con el id de la estacion en la tabla de locations.
  end

  # GET /stations/1/edit
  def edit
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'Station was successfully created.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    @current_location_value = Location.find_by_station_id(@station.id).id
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
        format.json { render :show, status: :ok, location: @station }
        Location.find_by_id(@current_location_value).destroy
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    Location.find_by_station_id(@station.id).destroy
    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    def verify_session

    if current_user.nil?
      redirect_to log_in_url, :notice => "Debes iniciar sesion"
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:legal_name, :counter_honesty, :counter_speed_service, :counter_customer_service, :counter_comments, location_attributes:[:address])
    end
end
