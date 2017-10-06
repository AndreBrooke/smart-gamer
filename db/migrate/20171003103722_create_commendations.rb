class CreateCommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :commendations do |t|
    	t.string :image
    	t.string :name
    	t.integer :count, default: 0
    	t.belongs_to :user
      t.timestamps
    end
  end
end
