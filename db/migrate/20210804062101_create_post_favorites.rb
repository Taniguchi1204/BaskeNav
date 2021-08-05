class CreatePostFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :post_favorites do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
    add_index :post_favorites, :user_id
    add_index :post_favorites, :post_id
  end
end
