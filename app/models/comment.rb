class Comment < ApplicationRecord
	belongs_to :user
  belongs_to :article
  before_save :update_achievement_progress

  def update_achievement_progress
    badges = Badge.where("name ILIKE ?", "%reply%")
    badges.each do |badge|
      achievement = self.user.achievements.find_by(badge_id: badge.id)
      achievement.increment!(:progress)
    end
  end
end
