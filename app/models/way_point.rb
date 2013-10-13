class WayPoint < ActiveRecord::Base
  belongs_to :place
  belongs_to :my_map
end
