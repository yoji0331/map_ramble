module PlaceImagesHelper
  def place_image_tag(place, options = {})
    if place.image.present?
      path = place_path(place, format: place.image.extension)
      link_to(image_tag(path, { alt: place.name }.merge(options)), path)
    else
      ""
    end
  end
end
