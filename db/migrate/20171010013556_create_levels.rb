class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
    	t.integer :level
    	t.integer :min_points
    	t.integer :max_points
      t.timestamps
    end
  end
end
