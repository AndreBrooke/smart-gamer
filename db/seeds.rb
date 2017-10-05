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

# FIXME this url have problem https://www.joindota.com/en/news/24869-malaysia-officially-recognize-esports