class MyMap < ActiveRecord::Base
  belongs_to :user
  has_many :way_points

  def add_place(place_id)
    current_point = way_points.find_by(place_id: place_id)
    unless current_point
      current_point = way_points.build(place_id: place_id)
    end
    current_point
  end

  def registrated(place_id)
    current_point = way_points.find_by(place_id: place_id)
    current_point
  end
end
