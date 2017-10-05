class Article < ApplicationRecord
	default_scope { order(created_at: :desc) }
  scope :title, ->(title) { where "title like ?", "%#{title}%" }
  scope :content, -> (content) { where "content like ?", "%#{content}%" }

	def self.search(search_params)
    articles = Article.title(search_params)
    articles += Article.content(search_params)
    articles
  end
end
