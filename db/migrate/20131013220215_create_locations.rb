class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.float :accuracy
      t.float :altitudeAccuracy
      t.float :heading
      t.float :speed
      t.integer :error_code
      t.timestamp :timestamp
      t.references :user, index: true

      t.timestamps
    end
  end
end
