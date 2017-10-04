class CreateFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :followers do |t|
      t.belongs_to :users, index: true, foreign_key: true
      t.integer :follower_id
      t.timestamps
    end
  end
end
