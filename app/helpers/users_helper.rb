module UsersHelper
	def get_owned_games(user)	
    steam_id = user.uid.to_i + 76561197960265728
    RestClient.get("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=1DB6B5F9C6DA54FE150CFCABCB94447A&steamid=#{steam_id}&include_appinfo=1&include_played_free_games=1&format=json")
	end
end
