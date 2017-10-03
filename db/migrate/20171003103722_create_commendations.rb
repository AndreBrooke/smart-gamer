class CreateCommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :commendations do |t|

      t.timestamps
    end
  end
end
