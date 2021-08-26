class CreateFacilityPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_places do |t|
      t.integer :facility_id
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
    add_index :facility_places, :facility_id
  end
end
