class CreateFacilityComments < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_comments do |t|
      t.integer :user_id,     null: false
      t.integer :facility_id, null: false
      t.text :comment,        null: false
      t.float :rate,          null: false

      t.timestamps
    end
    add_index :facility_comments, :user_id
    add_index :facility_comments, :facility_id
  end
end
