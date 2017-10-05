class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
  validates :title, presence: true
	default_scope { order(created_at: :desc) }
  scope :title, ->(title) { where "lower(title) like ?", "%#{title.downcase}%" }
  scope :content, -> (content) { where "lower(content) like ?", "%#{content.downcase}%" }

	def self.search(search_params)
    articles = Article.title(search_params)
    articles += Article.content(search_params)
    articles
  end
end
