json.array!(@way_points) do |way_point|
  json.extract! way_point, :place_id, :my_map_id
  json.url way_point_url(way_point, format: :json)
end
