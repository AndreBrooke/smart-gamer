class Comment < ApplicationRecord
	belongs_to :user
  belongs_to :article
  before_save :update_achievement_progress, :create_activity

  def update_achievement_progress
    badges = Badge.where("name ILIKE ?", "%reply%")
    badges.each do |badge|
      achievement = self.user.achievements.find_by(badge_id: badge.id)
      achievement.increment!(:progress) unless achievement.status
      unless achievement.status
        if achievement.progress == badge.goal
          achievement.update_attribute(:status, true) 
          self.user.activities.create(content: "#{self.user.nickname} unlocked a new badge - #{badge.name}")
        end
      end
    end
  end

  def create_activity
    unless self == Comment.last
      self.user.activities.create(content: "#{self.user.nickname} posted a comment to #{self.article.title}")
    end
  end
end
