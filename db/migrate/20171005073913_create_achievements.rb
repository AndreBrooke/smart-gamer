class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
    	t.references :user
    	t.references :badge
    	t.boolean :status, default: false
    	t.integer :progress
      t.timestamps
    end
  end
end
