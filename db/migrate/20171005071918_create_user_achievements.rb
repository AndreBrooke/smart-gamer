class CreateUserAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :user_achievements do |t|
    	t.string :image
    	t.string :name
    	t.string :description
      t.timestamps	
    end
  end
end
