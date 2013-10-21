class CheckinsController < ApplicationController
  before_action :set_checkin, only: [:destroy]
  before_action :login_required, except: :create


  # GET /checkins
  # GET /checkins.json
  def index
    if current_user.try(:admin?)
      @checkins = Checkin.all
      @checkins_for_json = current_user.checkins
    elsif user_signed_in?
      @checkins = current_user.checkins
      @checkins_for_json = @checkins
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkins_for_json }
    end
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @place = Place.find(params[:places_id])
    if user_signed_in?
      location = current_user.locations.last
      location_for_json = location
      if current_user.admin?
        location = Location.last
      end
    end

    if user_signed_in?
      @tmp = Checkin.where(["place_id = ? and user_id = ?", @place.id, current_user.id]).first
      if @tmp
        @checkin = @tmp
        respond_to do |format|
          if @checkin.touch
            format.html { redirect_to @place, notice: '再チェックインしました。' }
            format.json { render json: @place, status: :checkin, location: @place }
          else
            format.html { redirect_to @place, notice: 'チェックインできませんでした。' }
            format.json { render json: @place.errors, status: :unprocessable_entity }
          end
        end
      else
        @checkin = Checkin.new({"lat" => location.latitude, "lng" => location.longitude, "accuracy" => location.accuracy})
        @checkin.place_id = @place.id
        @checkin.user_id = current_user.id
        respond_to do |format|
          if @checkin.save
            format.html { redirect_to @place, notice: 'チェックインしました。' }
            format.json { render json: @place, status: :checkin, location: @place }
          else
            format.html { redirect_to @place, notice: 'チェックインできませんでした。' }
            format.json { render json: @place.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin.destroy
    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:user_id, :place_id)
    end
end
