class User < ApplicationRecord
  include Clearance::User
  has_many :achievements, dependent: :destroy
  has_many :badges, through: :achievements
  has_many  :comments, dependent: :destroy
  has_many :followers
  has_many :commendations, dependent: :destroy
  has_many :activities, dependent: :destroy
  validates :desired_playtime, numericality: { only_integer: true }
  has_many  :playtimes
  has_many :likes
  enum status: [ :gamer, :admin ]
  enum privacy: [ :public_profile, :friend_only, :private_profile]
  scope :nickname, ->(nickname) { where "lower(nickname) like ?", "%#{nickname.downcase}%" }
  scope :email, ->(email) { where "lower(email) like ?", "%#{email.downcase}%" }
  scope :uid, ->(uid) { where uid: uid }
  after_save :create_achievements, :create_activity
  after_create :create_achievements # for seed file

  def privacy_check(current_user)
    if privacy == "public_profile"
      return false
    elsif privacy == "friend_only" && User.check_follower(current_user.id, self.id)
      return false
    else
      return true
    end
  end

  def self.search(search)
    if search
      where("nickname ILIKE :search OR name ILIKE :search OR email ILIKE :search OR uid ILIKE :search", search: "%#{search}%")
    else
      all
    end
  end

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
    check_online_status if playtime.today_playtime > self.desired_playtime*60
    TrackJob.set(wait: 1.minutes).perform_later(self.id)
  end

  def self.from_omniauth(auth)
    info = auth['info']
    user ||= find_or_initialize_by(uid: (auth['uid'].to_i - 76561197960265728).to_s)
    user.nickname ||= info['nickname']
    user.avatar_url ||= info['image']
    user.profile_url ||= info['urls']['Profile']
    user.profile_url = auth['extra']['raw_info']['avatar_full']
    user.name ||= info['name']
    user.email ||= "example@na.com"
    user.password ||= SecureRandom.hex(10)
    user.personastate = auth["extra"]['raw_info']['personastate']
    user
  end

  def self.check_follower(user_id, follower_id)
    user = User.find(user_id)
    if user
      relation = user.followers.find_by(follower_id: follower_id)
      if relation
        return relation.status
      else
        return false
      end
    end
  end

  def create_achievements
    if self.achievements.empty?
      Badge.all.each do |badge|
        self.achievements.create(badge_id: badge.id)
      end
    end
  end

  def check_online_status
    if self.personastate == 1
      NotificationJob.perform_later(self.id, "online_after_exceed")
    end
  end

  def create_activity
    if self.activities.empty?
      self.activities.create(content: " joined SmartGamer")
    end
  end

  def create_user_notifications
    today_playtime = self.playtimes.where(date: Date.today)[0].today_playtime
    desired_playtime = self.desired_playtime * 60
    desired_playtime - today_playtime
  end
end
