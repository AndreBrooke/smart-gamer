class TrackJob < ApplicationJob
  queue_as :default

  def perform(steam_id)
    # Do something later
    data = Hash.new
    profile = RestClient.get"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=1DB6B5F9C6DA54FE150CFCABCB94447A&steamids=#{steam_id}"
    played_games = RestClient.get"http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/?key=1DB6B5F9C6DA54FE150CFCABCB94447A&steamid=#{steam_id}&format=json"
    data[:personastate] = JSON.parse(profile)["response"]["players"].first["personastate"]
    games_arr = JSON.parse(played_games)["response"]["games"]
    playtime_forever = 0
    games_arr.each do |x|
      playtime_forever += x["playtime_forever"]
    end
    data[:playtime_forever] = playtime_forever
    return data
  end
end
