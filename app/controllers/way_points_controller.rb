class WayPointsController < ApplicationController
  before_action :set_way_point, only: [:show, :edit, :update, :destroy]

  # GET /way_points
  # GET /way_points.json
  def index
    @way_points = WayPoint.all
  end

  # GET /way_points/1
  # GET /way_points/1.json
  def show
  end

  # GET /way_points/new
  def new
    @way_point = WayPoint.new
  end

  # GET /way_points/1/edit
  def edit
  end

  # POST /way_points
  # POST /way_points.json
  def create
    @my_map = current_my_map
    place = Place.find(params[:place_id])
    @way_point = @my_map.add_place(place.id)

    respond_to do |format|
      if @way_point.save
        format.html { redirect_to @way_point.my_map, notice: 'マイマップに追加しました。' }
        format.json { render action: 'show', status: :created, location: @way_point }
      else
        format.html { render action: 'new' }
        format.json { render json: @way_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /way_points/1
  # PATCH/PUT /way_points/1.json
  def update
    respond_to do |format|
      if @way_point.update(way_point_params)
        format.html { redirect_to @way_point, notice: 'Way point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @way_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /way_points/1
  # DELETE /way_points/1.json
  def destroy
    @my_map = current_my_map
    if @way_point.my_map_id == @my_map.id
      @way_point.destroy
      session[:my_map_id] = nil
      respond_to do |format|
        format.html { redirect_to @my_map }
        format.json { head :no_content }
      end
    else
      redirect_to @my_map
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_way_point
      @way_point = WayPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def way_point_params
      params.require(:way_point).permit(:place_id, :my_map_id)
    end
end
