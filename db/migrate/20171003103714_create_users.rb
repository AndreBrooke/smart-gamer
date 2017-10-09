class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :email
      t.string :encrypted_password, limit: 128, null: true
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
      t.string :uid
      t.string :nickname
      t.string :avatar_url
      t.string :profile_url
      t.string :name
      t.integer :personastate
      t.text :about
    end

    # add_index :users, :email
    add_index :users, :remember_token
    add_index :users, :uid, unique: true

  end
end
