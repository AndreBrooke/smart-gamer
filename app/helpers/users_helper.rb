module UsersHelper
	def get_owned_games(user)	
    steam_id = user.uid.to_i + 76561197960265728
    RestClient.get("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=1DB6B5F9C6DA54FE150CFCABCB94447A&steamid=#{steam_id}&include_appinfo=1&include_played_free_games=1&format=json")
	end

	def get_recent_games(user)
		steam_id = user.uid.to_i + 76561197960265728
		RestClient.get("http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/?key=1DB6B5F9C6DA54FE150CFCABCB94447A&steamid=#{steam_id}&include_appinfo=1&include_played_free_games=1&format=json")
	end

	def get_toxicidity_score(user)
		steam_id = user.uid.to_i
		RestClient.get("https://api.opendota.com/api/players/#{steam_id}/wordcloud")
	end
end
