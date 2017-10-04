module ArticlesHelper
	def get_shared_article_params(url)
		response = RestClient.get("http://link-thumbnailer-api.herokuapp.com/thumbnails/new\?url\=#{url}")
		share_json = JSON.parse(response.body)
		{ url: share_json["url"], title: share_json["title"], image: share_json["images"].first["src"].to_s }
	end
end
