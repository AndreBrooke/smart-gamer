class CreateBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
    	t.string :image
    	t.string :name
    	t.string :description
    	t.integer :goal
      t.timestamps	
    end
  end
end
