class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :login_required, except: :create


  # GET /locations
  # GET /locations.json
  def index
    if current_user.try(:admin?)
      @locations = Location.all
      @locations_for_json = current_user.locations
    elsif user_signed_in?
      @locations = current_user.locations
      @locations_for_json = @locations
    end
    @locations = Location.all
  end

  # GET /locations/resent
  # GET /locations/resent.json
  def resent
    if current_user.try(:admin?)
      @location = Location.last
      @location_for_json = current_user.locations.last
    elsif user_signed_in?
      @location = current_user.locations.last
      @location_for_json = @location
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @location_for_json }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    if current_user.try(:admin?)
      @location = Location.find(params[:id])
    elsif user_signed_in?
      tmp = Location.find(params[:id])
      if tmp.user_id == current_user.id
        @location = tmp
      end
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    if user_signed_in?
      @location.user_id = current_user.id
    end

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:latitude, :longitude, :accuracy, :altitudeAccuracy, :heading, :speed, :error_code, :timestamp, :user_id)
    end
end
