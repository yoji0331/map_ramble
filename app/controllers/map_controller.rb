class MapController < ApplicationController
  layout "map"
  def index
    @places = Place.all
    @initial = Initial.first
    @my_map = current_my_map
    
    if user_signed_in?
      # チェックインの取得
      @checkins = current_user.checkins

      # 位置情報の履歴が指定された場合
      if params[:locations_id]
        @location = Location.where("id = ? AND user_id = ?", params[:locations_id], current_user.id).last
        if @location.present?
          @initial.lat = @location.latitude
          @initial.lng = @location.longitude
          @initial.zoom = 15
        end
      end
    end

    if params[:places_id]
      begin
        @place = Place.find(params[:places_id])
      rescue
      else
        @initial.places_id = params[:places_id]
        @initial.lat = @place.lat
        @initial.lng = @place.lng
        @initial.zoom = 15
      end
    end

  end
end
