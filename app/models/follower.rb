class Follower < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :follower_id, presence: true
end
