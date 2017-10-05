class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
  validates :title, presence: true
	default_scope { order(created_at: :desc) }
  scope :title, ->(title) { where "lower(title) like ?", "%#{title.downcase}%" }
  scope :content, -> (content) { where "lower(content) like ?", "%#{content.downcase}%" }

	def self.search(search)
    if search
      where("title ILIKE :search OR content ILIKE :search", search: "%#{search}%")
    else
    	all
    end
  end
end
