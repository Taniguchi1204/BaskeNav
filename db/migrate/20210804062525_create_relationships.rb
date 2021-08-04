class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :following_id, null: false
      t.integer :followed_id,  null: false

      t.timestamps
    end
    add_index :relationships, :following_id
    add_index :relationships, :followed_id
  end
end
