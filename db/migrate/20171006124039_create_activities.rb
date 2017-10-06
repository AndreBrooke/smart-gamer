class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.string :content
      t.timestamps
    end
  end
end
