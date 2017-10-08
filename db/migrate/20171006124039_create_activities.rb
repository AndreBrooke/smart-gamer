class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.belongs_to :comment, default: 0, optional: true, index: true, foreign_key: true
    	t.string :content
    	t.integer :comment_id
    	t.timestamps
    end
  end
end
