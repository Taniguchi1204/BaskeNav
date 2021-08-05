class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.references :user, null: false, forign_key: true
      
      t.timestamps
    end
  end
end
