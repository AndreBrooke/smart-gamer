class Playtime < ApplicationRecord
  belongs_to  :user
  # before_save :update_today_playtime

  private

  def update_today_playtime
    yesterday = user.playtimes.find_by(date: Date.today-1)
    if yesterday
      playtime = self[:total_playtime] - yesterday[:total_playtime]
      if playtime != self.today_playtime
        self.today_playtime = playtime
        check_desired_playtime
      end
    else
      self.today_playtime = nil
    end
  end

  def check_desired_playtime
    if today_playtime > user.desired_playtime
      NotificationJob.perform_later(user.id, "exceed")
    end
  end

end
