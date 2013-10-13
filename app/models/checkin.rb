class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  validate do
    place = Place.find(place_id)
    location = Location.new({ :latitude => self.lat, :longitude => self.lng, :accuracy => self.accuracy })
    unless Checkin.enable_checkin(place, location)
      errors.add(:base, :invalid)
    end
  end

#  private
  def Checkin.get_distance(lat1, lng1, lat2, lng2)
    dy = (lat1 - lat2) / 360 * Math::PI
    dx = (lng1 - lng2) / 360 * Math::PI
    muy = (lat1 + lat2) / 2 / 360 * Math::PI
    a = 6378137.000
    b = 6356752.314245
    e = Math::sqrt((a * a - b * b) / a / a)
    w = Math::sqrt(1 - e * e * Math::sin(muy) * Math::sin(muy))
    m = a * (1 - e * e) / w / w / w
    n = a / w
    d = Math::sqrt(dy * dy * m * m + dx * dx * n * n * Math::cos(muy) * Math::cos(muy))
  end

  def Checkin.enable_checkin(place, location)
    if location == nil
      checkin = false
    elsif get_distance(place.lat, place.lng, location.latitude, location.longitude) < location.accuracy then
      checkin = true
    else
      checkin = false
    end
    checkin
  end

end
