json.array!(@checkins) do |checkin|
  json.extract! checkin, :user_id, :place_id
  json.url checkin_url(checkin, format: :json)
end
