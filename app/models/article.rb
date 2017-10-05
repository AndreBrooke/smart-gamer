class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
  validates :title, presence: true
	default_scope { order(created_at: :desc) }

	def self.search(search)
    if search
      where("title ILIKE :search", search: "%#{search}%")
    else
    	all
    end
  end
end
