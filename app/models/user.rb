class User < ApplicationRecord
  include Clearance::User

  has_many  :playtimes
  enum status: [ :gamer, :admin ]

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

  def self.from_omniauth(auth)
    info = auth['info']
    user = find_or_initialize_by(uid: (auth['uid'].to_i - 76561197960265728).to_s)
    user.nickname = info['nickname']
    user.avatar_url = info['image']
    user.profile_url = info['urls']['Profile']
    user.name = info['name']
    user.email ||= "example@na.com"
    user.password = SecureRandom.hex(10)
    user.personastate = auth["extra"]['raw_info']['personastate']
    user
  end
end
