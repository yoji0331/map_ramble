json.array!(@initials) do |initial|
  json.extract! initial, :lat, :lng, :zoom
  json.url initial_url(initial, format: :json)
end
