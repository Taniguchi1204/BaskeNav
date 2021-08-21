class CreatePostPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :post_places do |t|
      t.integer  :post_id
      t.string   :address
      t.float    :longitude
      t.float    :latitude

      t.timestamps
    end
    add_index :post_places, :post_id
  end
end
