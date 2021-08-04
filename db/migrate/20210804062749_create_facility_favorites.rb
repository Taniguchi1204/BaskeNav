class CreateFacilityFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_favorites do |t|
      t.integer :user_id,     null: false
      t.integer :facility_id, null: false

      t.timestamps
    end
    add_index :facility_favorites, :user_id
    add_index :facility_favorites, :facility_id
  end
end
