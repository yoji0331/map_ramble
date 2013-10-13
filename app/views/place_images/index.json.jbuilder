json.array!(@place_images) do |place_image|
  json.extract! place_image, :place_id, :data, :content_type
  json.url place_image_url(place_image, format: :json)
end
