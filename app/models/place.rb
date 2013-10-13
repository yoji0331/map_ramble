class Place < ActiveRecord::Base
  belongs_to :category

  has_many :checkins, through: :checkins, source: :member
  has_many :way_points
  has_one :image, class_name: "PlaceImage", dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true

end
