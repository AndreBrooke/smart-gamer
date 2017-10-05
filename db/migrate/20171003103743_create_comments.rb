class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.belongs_to :article, index: true, foreign_key: true
    	t.string :reply_article
      t.timestamps
    end
  end
end
