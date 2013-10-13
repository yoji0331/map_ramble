class PlaceImagesController < ApplicationController
  before_action :set_place_image, only: [:show, :edit, :update, :destroy]

  # GET /place_images
  # GET /place_images.json
  def index
    @place_images = PlaceImage.all
  end

  # GET /place_images/1
  # GET /place_images/1.json
  def show
  end

  # GET /place_images/new
  def new
    @place_image = PlaceImage.new
  end

  # GET /place_images/1/edit
  def edit
  end

  # POST /place_images
  # POST /place_images.json
  def create
    @place_image = PlaceImage.new(place_image_params)

    respond_to do |format|
      if @place_image.save
        format.html { redirect_to @place_image, notice: 'Place image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @place_image }
      else
        format.html { render action: 'new' }
        format.json { render json: @place_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /place_images/1
  # PATCH/PUT /place_images/1.json
  def update
    respond_to do |format|
      if @place_image.update(place_image_params)
        format.html { redirect_to @place_image, notice: 'Place image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /place_images/1
  # DELETE /place_images/1.json
  def destroy
    @place_image.destroy
    respond_to do |format|
      format.html { redirect_to place_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place_image
      @place_image = PlaceImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_image_params
      params.require(:place_image).permit(:place_id, :data, :content_type)
    end
end
