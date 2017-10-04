class User < ApplicationRecord
  include Clearance::User

  has_many  :playtimes

  def self.update
    User.all do |x|
      data = Track.job.perform_later(x.uid)
      playtime = x.playtimes.find_by(date: Date.today)
      if playtime == nil
        x.playtimes.create(date: Date.today, total_playtime: data[:playtime_forever])
      else
        playtime.update(total_playtimes: data[:playtime_forever])
      end
    end
  end
end
