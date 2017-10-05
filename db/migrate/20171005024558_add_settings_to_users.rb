class AddSettingsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :privacy, :integer, default: 0
    add_column :users, :desired_playtime, :integer, default: 2
  end
end
