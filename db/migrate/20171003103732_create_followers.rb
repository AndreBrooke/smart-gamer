class CreateFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :followers do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :follower_id
      t.boolean :status, index: true, default: true
      t.timestamps
    end
  end
end
