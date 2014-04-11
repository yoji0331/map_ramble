class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :admin_login_required, except: [:index, :show]

  # GET /places
  # GET /places.json
  def index
    @places = Place.all
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @my_map = current_my_map
    @way_point = @my_map.registrated(@place)

    if user_signed_in?
      location = current_user.locations.last
      location_for_json = location
      if current_user.admin?
        location = Location.last
        location_for_json = current_user.locations.last
      end

      if Checkin::enable_checkin(@place, location)
        @enable_checkin = true
      end
      @checkin = Checkin.where("user_id = ? AND place_id = ?", current_user.id, @place.id).order("updated_at DESC").limit(1)[0]
      if @checkin.present?
        @had_been_checkined = true
      end

      if @enable_checkin.present?
        @checkin_message = "チェックイン"
        if @had_been_checkined.present?
          @checkin_message = "再チェックイン"
        end
      end
    end

    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "places/show"
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @place }
    end
  end

  # GET /places/new
  def new
    @place = Place.new
    @categories = Category.all
    @place.build_image
  end

  # GET /places/1/edit
  def edit
    @categories = Category.all
    @place.build_image unless @place.image
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :category_id, :lat, :lng, :description, image_attributes: [:uploaded_image])
    end

    # 画像送信
    def send_image
      if @place.image.present?
        send_data @place.image.data, type: @place.image.content_type, disposition: "inline"
      else
        raise NotFount
      end
    end
end
