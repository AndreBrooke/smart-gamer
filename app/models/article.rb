class Article < ApplicationRecord
	validates :title, presence: true
	default_scope { order(created_at: :desc) }

	def self.search(search)
    if search
      where("title ILIKE :search", search: "%#{search}%")
    end
  end
end
