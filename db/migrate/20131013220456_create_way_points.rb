class CreateWayPoints < ActiveRecord::Migration
  def change
    create_table :way_points do |t|
      t.references :place, index: true
      t.references :my_map, index: true

      t.timestamps
    end
  end
end
