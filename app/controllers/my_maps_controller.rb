class MyMapsController < ApplicationController
  before_action :set_my_map, only: [:show, :edit, :update, :destroy]

  # GET /my_maps
  # GET /my_maps.json
  def index
    @my_maps = MyMap.all
  end

  # GET /my_maps/1
  # GET /my_maps/1.json
  def show
  end

  # GET /my_maps/new
  def new
    @my_map = MyMap.new
  end

  # GET /my_maps/1/edit
  def edit
  end

  # POST /my_maps
  # POST /my_maps.json
  def create
    @my_map = MyMap.new(my_map_params)

    respond_to do |format|
      if @my_map.save
        format.html { redirect_to @my_map, notice: 'My map was successfully created.' }
        format.json { render action: 'show', status: :created, location: @my_map }
      else
        format.html { render action: 'new' }
        format.json { render json: @my_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my_maps/1
  # PATCH/PUT /my_maps/1.json
  def update
    respond_to do |format|
      if @my_map.update(my_map_params)
        format.html { redirect_to @my_map, notice: 'My map was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @my_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_maps/1
  # DELETE /my_maps/1.json
  def destroy
    @my_map.destroy
    respond_to do |format|
      format.html { redirect_to my_maps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_map
      @my_map = MyMap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def my_map_params
      params.require(:my_map).permit(:user_id)
    end
end
