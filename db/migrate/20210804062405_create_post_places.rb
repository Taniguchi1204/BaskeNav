class CreatePostPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :post_places do |t|
      t.integer :post_id, null: false
      t.float :longitude, null: false
      t.float :latitude,  null: false

      t.timestamps
    end
    add_index :post_places, :post_id
  end
end
