class CreateMyMaps < ActiveRecord::Migration
  def change
    create_table :my_maps do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
