class CreateInitials < ActiveRecord::Migration
  def change
    create_table :initials do |t|
      t.float :lat
      t.float :lng
      t.integer :zoom

      t.timestamps
    end
  end
end
