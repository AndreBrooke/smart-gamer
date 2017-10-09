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

Badge.create(name: "Reply Novice", description: "Reply 5 articles", image: "ProfileIcon3015.png", goal: 5)
Badge.create(name: "Reply Pro", description: "Reply 15 articles", image: "ProfileIcon3016.png", goal: 15)
Badge.create(name: "Reply Guru", description: "Reply 50 articles", image: "ProfileIcon3017.png", goal: 50)

Badge.create(name: "First Step To A Bigger Goal", description: "Achieve Goal for 1 day", image: "bronze.png", goal: 1)
Badge.create(name: "Good Discipline Goal", description: "Achieve Goal for 1 week", image: "silver.png", goal: 7)
Badge.create(name: "I Can Do It", description: "Achieve Goal for 1 month ", image: "gold.png", goal: 30)

Badge.create(name: "5 Badges", description: "Obtained 5 Badges", image: "BronzeBadgeSeason2.png", goal: 5)
Badge.create(name: "50 Badges", description: "Obtained 50 Badges", image: "SilverBadgeSeason2.png", goal: 50)
Badge.create(name: "100 Badges", description: "Obtained 100 Baddges", image: "GoldBadgeSeason2.png", goal: 100)


User.create(email: "haujiechan@gmail.com", password: SecureRandom.hex(10), uid: "346709119", nickname: "Targaryen", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c8/c8738ddf2d587d3c5e4da39243167cffa674cbd3_full.jpg", profile_url: "http://steamcommunity.com/profiles/76561198306974847/", name: "Chan Hau Jie")
User.create(email: "yizen@hotmail.com", password: SecureRandom.hex(10), uid: "100893614", nickname: "Peacemaker", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/55/55ba503630606e10ba2a99e8d9c1541be1d391d7_full.jpg", profile_url: "http://steamcommunity.com/id/kooyizen/", name: "Koo Yi Zen")
User.create(email: "waikit@gmail.com", password: SecureRandom.hex(10), uid: "136990519", nickname: "Your Mum's Pussy", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/eb/eb89dcaad32cc26b3be6e63177faffc06c494f82_full.jpg", profile_url: "http://steamcommunity.com/profiles/76561198097256247/", name: "kit")
User.create(email: "and_book66@hotmail.com", password: SecureRandom.hex(10), uid: "84861340", nickname: "Dernum-X", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d7/d70116b67392386f1a1b64e82f319be6c0f165fe_full.jpg", profile_url: "http://steamcommunity.com/id/Dernum-X/", name: "Andre Brooke")
User.create(email: "wilson@gmail.com", password: SecureRandom.hex(10), uid: "205485506", nickname: "Freecs", avatar_url: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg", profile_url: "http://steamcommunity.com/profiles/76561198165751234", name: "Wilson")



User.all.each do |x|
  playtime = rand(1000..4000)
  x.playtimes.create(date: Date.today - 30, total_playtime: playtime)
  29.downto(0) do |loop|
    today_playtime = rand(100..200)
    playtime += today_playtime
    x.playtimes.create(date: Date.today - loop, total_playtime: playtime, today_playtime: today_playtime )
  end

  user_count = User.all.count
  other_users = (1..user_count).to_a - [x.id]
  rand(1...user_count).times do |i|
	  x.followers.create(follower_id: other_users.delete(other_users.sample))
	end

	x.commendations.create(image: "", name: "Friendly")
	x.commendations.create(image: "", name: "Teamwork")
	x.commendations.create(image: "", name: "Tilt-Proof")
end
