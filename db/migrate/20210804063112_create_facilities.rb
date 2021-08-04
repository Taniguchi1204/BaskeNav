class CreateFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities do |t|
      t.integer :admin_id,    null: false
      t.integer :opening,     null: false
      t.integer :closing,     null: false
      t.string :station,      null: false
      t.string :parking,      null: false
      t.string :postcode,     null: false
      t.string :address,      null: false
      t.string :phone_number, null: false
      t.string :email,        null: false
      t.text  :comment

      t.timestamps
    end
    add_index :facilities, :admin_id
  end
end
