class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false

      t.timestamps
    end
    add_index :entries, :user_id
    add_index :entries, :room_id
  end
end
