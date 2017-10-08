class Activity < ApplicationRecord
	belongs_to :user
	belongs_to :comment, optional: true
	validates :content, presence: true
	default_scope { order(created_at: :desc) }
end
