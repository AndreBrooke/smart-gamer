module HomeHelper
	def get_quote
		RestClient.get("http://api.forismatic.com/api/1.0/?method=getQuote&key=&format=json&lang=en")
	end

	def fallback_quote
		{"quoteText"=>"Play Smart, Not Hard.", "quoteAuthor"=>"Lee Siew Ching", "senderName"=>"", "senderLink"=>"", "quoteLink"=>""}
	end

	def get_activities
		current_user_activities = current_user.activities
		followers_activities = current_user_activities.to_a
		current_user.followers.each do |follower|
			if follower.status
				followers_activities += User.find(follower.follower_id).activities.to_a
			end
		end
		followers_activities
	end
end
