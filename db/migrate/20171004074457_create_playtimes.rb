class CreatePlaytimes < ActiveRecord::Migration[5.1]
  def change
    create_table :playtimes do |t|
      t.belongs_to  :user
      t.integer     :today_playtime, default: 0
      t.integer     :total_playtime
      t.date        :date
      t.timestamps
    end
  end
end
