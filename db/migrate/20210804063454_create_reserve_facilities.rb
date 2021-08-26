class CreateReserveFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :reserve_facilities do |t|
      t.integer  :facility_id,     null: false
      t.integer  :user_id,         null: false
      t.datetime :start,           null: false
      t.datetime :finish,          null: false
      t.string   :number,          null: false
      t.boolean  :with_friend,  default: false, null: false
      t.boolean  :confirm,      default: false, null: false
      t.text     :comment

      t.timestamps
    end
    add_index :reserve_facilities, :facility_id
    add_index :reserve_facilities, :user_id
  end
end
