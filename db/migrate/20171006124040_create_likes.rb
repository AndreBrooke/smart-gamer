class CreateLikes < ActiveRecord::Migration[5.0]
	def change
			create_table :likes do |t|
			t.boolean :vote_type, :default => false
			t.belongs_to :user, index: true, foreign_key: true
			t.belongs_to :commendation, index: true, foreign_key: true
			t.timestamp
		end
	end
end