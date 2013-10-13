class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.references :category, index: true
      t.float :lat
      t.float :lng
      t.text :description

      t.timestamps
    end
  end
end
