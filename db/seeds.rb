# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rake db:seed

include ArticlesHelper

url = "https://www.flaktest.com/studied-benefits-playing-esports/"
Article.create(get_shared_article_params(url))

url = "http://es.me/en/2017/08/18/another-esports-academy-opens-doors-malaysia/"
Article.create(get_shared_article_params(url))

Article.create(title: "Stay tuned for our upcoming event", content: "Hint: new badge")

url = "http://www.stadiumastro.com/sports/e-sports/article/growth-of-esports-in-malaysia/35043"
Article.create(get_shared_article_params(url))

Article.create(title: "Tournament", content: "month-long tournament")

url = "http://www.psychologyofgames.com/2016/12/deliberate-practice-and-getting-good/"
Article.create(get_shared_article_params(url))

Badge.create(name: "Login Novice", description: "Login for 7 days consecutively", image: "Champ_Mastery_Db.png", goal: 7)
Badge.create(name: "Log-athon", description: "Login for 14 days consecutively", image: "Champ_Mastery_Cb.png", goal: 14)
Badge.create(name: "Everyday I'm Login-ing", description: "Login for 30 days consecutively", image: "Champ_Mastery_Bb.png", goal: 30)

Badge.create(name: "Reply Novice", description: "Reply 5 articles", image: "bronze1.png", goal: 5)
Badge.create(name: "Reply Pro", description: "Reply 15 articles", image: "silver1.png", goal: 15)
Badge.create(name: "Reply Guru", description: "Reply 50 articles", image: "gold1.png", goal: 50)

Badge.create(name: "First Step To A Bigger Goal", description: "Achieve Goal for 1 day", image: "bronze.png", goal: 1)
Badge.create(name: "Good Discipline Goal", description: "Achieve Goal for 1 week", image: "silver.png", goal: 7)
Badge.create(name: "I Can Do It", description: "Achieve Goal for 1 month ", image: "gold.png", goal: 30)

Badge.create(name: "5 Badges", description: "Obtained 5 Badges", image: "BronzeBadgeSeason2.png", goal: 5)
Badge.create(name: "50 Badges", description: "Obtained 50 Badges", image: "SilverBadgeSeason2.png", goal: 50)
Badge.create(name: "100 Badges", description: "Obtained 100 Baddges", image: "GoldBadgeSeason2.png", goal: 100)

min = 0
max = 10
15.times do |i|
  Level.create(level: i + 1, min_points: min, max_points: max)
  min = max + 1
  max *= 2
end

User.create(email: "haujiechan@gmail.com", password: SecureRandom.hex(10), uid: "346709119", nickname: "Targaryen", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c8/c8738ddf2d587d3c5e4da39243167cffa674cbd3_full.jpg", profile_url: "http://steamcommunity.com/profiles/76561198306974847/", name: "Chan Hau Jie")
User.create(email: "waikit@gmail.com", password: SecureRandom.hex(10), uid: "136990519", nickname: "Your Mum's Pussy", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/eb/eb89dcaad32cc26b3be6e63177faffc06c494f82_full.jpg", profile_url: "http://steamcommunity.com/profiles/76561198097256247/", name: "kit")
User.create(email: "and_book66@hotmail.com", password: SecureRandom.hex(10), uid: "84861340", nickname: "Dernum-X", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d7/d70116b67392386f1a1b64e82f319be6c0f165fe_full.jpg", profile_url: "http://steamcommunity.com/id/Dernum-X/", name: "Andre Brooke")

#first user
playtime = 50612
today_playtime = rand(100..300)
User.first.playtimes.create(date: Date.today, total_playtime: playtime, today_playtime: today_playtime)
loop = 1
while User.first.playtimes.last.total_playtime > 300
  playtime = playtime - today_playtime
  today_playtime = rand(100..300)
  User.first.playtimes.create(date: Date.today - loop, total_playtime: playtime, today_playtime: today_playtime)
  loop += 1
end
user_count = User.all.count
other_users = (1..user_count).to_a - [User.first.id]
rand(1...user_count).times do |i|
  User.first.followers.create(follower_id: other_users.delete(other_users.sample))
end
User.first.update(level: 3, points: 38)

#second user
playtime = 112235
today_playtime = rand(100..300)
User.second.playtimes.create(date: Date.today, total_playtime: playtime, today_playtime: today_playtime)
loop = 1
while User.second.playtimes.last.total_playtime > 300
  playtime = playtime - today_playtime
  today_playtime = rand(100..300)
  User.second.playtimes.create(date: Date.today - loop, total_playtime: playtime, today_playtime: today_playtime)
  loop += 1
end
user_count = User.all.count
other_users = (1..user_count).to_a - [User.second.id]
rand(1...user_count).times do |i|
  User.second.followers.create(follower_id: other_users.delete(other_users.sample))
end
User.second.update(level: 5, points: 100)

#third user
playtime = 207901
today_playtime = rand(100..300)
User.third.playtimes.create(date: Date.today, total_playtime: playtime, today_playtime: today_playtime)
loop = 1
while User.third.playtimes.last.total_playtime > 300
  playtime = playtime - today_playtime
  today_playtime = rand(100..300)
  User.third.playtimes.create(date: Date.today - loop, total_playtime: playtime, today_playtime: today_playtime)
  loop += 1
end
user_count = User.all.count
other_users = (1..user_count).to_a - [User.third.id]
rand(1...user_count).times do |i|
  User.third.followers.create(follower_id: other_users.delete(other_users.sample))
end
User.third.update(level: 4, points: 70)

User.all.each do |user|
  user.commendations.create(name: "Friendly")
  user.commendations.create(name: "Teamwork")
  user.commendations.create(name: "Tilt-Proof")
end
