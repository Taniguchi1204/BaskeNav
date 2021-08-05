class CreateFacilityPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_places do |t|
      t.integer :facility_id, null: false
      t.float :longitude,     null: false
      t.float :latitude,      null: false

      t.timestamps
    end
    add_index :facility_places, :facility_id
  end
end
