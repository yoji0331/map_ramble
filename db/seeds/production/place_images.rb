1.upto(36) do |idx|
  PlaceImage.create(
    {
      place_id: idx,
      data: File.open(Rails.root.join("db/seeds/development/place_images/#{idx}.jpg"), "rb").read,
      content_type: "image/jpeg"
    }
  )
end
