json.array!(@locations) do |location|
  json.extract! location, :latitude, :longitude, :accuracy, :altitudeAccuracy, :heading, :speed, :error_code, :timestamp, :user_id
  json.url location_url(location, format: :json)
end
