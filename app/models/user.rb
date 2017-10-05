class User < ApplicationRecord
  include Clearance::User

  validates :desired_playtime, numericality: { only_integer: true }

  has_many  :playtimes
  enum status: [ :gamer, :admin ]
  enum privacy: [ :public_profile, :friend_only, :private_profile]

  def self.update_playtime
    all.each do |x|
      TrackJob.perform_later(x.id)
    end
  end

  def update_today_playtime(data)
    playtime = self.playtimes.find_by(date: Date.today)
    if playtime == nil
      self.update(personastate: data[:personastate])
      self.playtimes.create(date: Date.today, total_playtime: data[:playtime_forever])
    else
      self.update(personastate: data[:personastate])
      playtime.update(total_playtime: data[:playtime_forever])
    end
    TrackJob.set(wait: 10.minutes).perform_later(self.id)
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
