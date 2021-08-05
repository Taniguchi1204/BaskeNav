class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.text :comment,    null: false

      t.timestamps
    end
    add_index :post_comments, :user_id
  end
end
