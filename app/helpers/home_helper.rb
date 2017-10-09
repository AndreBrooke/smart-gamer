module HomeHelper
	def get_quote
		RestClient.get("http://api.forismatic.com/api/1.0/?method=getQuote&key=&format=json&lang=en")
	end

	def fallback_quote
		{"quoteText"=>"Play Smart, Not Hard.", "quoteAuthor"=>"Lee Siew Ching", "senderName"=>"", "senderLink"=>"", "quoteLink"=>""}
	end

	def get_activities
		if signed_in?
			current_user_activities = current_user.activities
			followers_activities = current_user_activities.to_a
			current_user.followers.each do |follower|
				if follower.status
					followers_activities += User.find(follower.follower_id).activities.to_a
				end
			end
			followers_activities
		else
			[]
		end
	end

	def get_owned_games(user)
		# FIXME - not working
    steam_id = user.uid.to_i
    RestClient.get("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=1DB6B5F9C6DA54FE150CFCABCB94447A&steamid=#{steam_id}&include_appinfo=1&format=json")
	end
end
