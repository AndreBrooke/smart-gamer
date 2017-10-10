class Comment < ApplicationRecord
	belongs_to :user
  belongs_to :article
  has_many :activities, autosave: true, dependent: :destroy
  before_save :update_achievement_progress, :create_activity, :update_points
  after_create :update_activity

  def update_achievement_progress
    badges = Badge.where("name ILIKE ?", "%reply%")
    badges.each do |badge|
      achievement = self.user.achievements.find_by(badge_id: badge.id)
      achievement.increment!(:progress) unless achievement.status
      unless achievement.status
        if achievement.progress == badge.goal
          achievement.update_attribute(:status, true)
          user = self.user 
          user.activities.create(content: " unlocked a new badge - #{badge.name}")
          user.update_attribute(:points, user.points += 10) # to add points column to Badge
          check_points_level_up(user)
        end
      end
    end
  end

  def create_activity
    unless self == Comment.last
      self.user.activities.create(content: " posted a comment to #{self.article.title}", comment_id: self.id)
    end
  end

  def update_points
    unless self == Comment.last
      user = self.user
      user.update_attribute(:points, user.points += 5)
      check_points_level_up(user)
    end
  end

  def update_activity
    Activity.first.update_attribute(:comment_id, self.id)
  end

  def check_points_level_up(user)
    level_max_points = Level.find_by(level: user.level).max_points
    if user.points >= level_max_points
      user.update_attribute(:level, user.level += 1)
      user.activities.create(content: " reached Level #{user.level}")
    end
  end
end
