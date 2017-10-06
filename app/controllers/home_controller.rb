class HomeController < ApplicationController
	include HomeHelper

	def index
		# quote
		response = get_quote
		if response.code == 200
			# FIXME - not working if quoteText contains double quoted string
			begin
				JSON.parse(response.body)
			rescue
				@quote = fallback_quote
			else
				@quote = JSON.parse(response.body)
			end
		else
			@quote = fallback_quote
		end

		# search results
		@articles_home = Article.search(params[:search]).first(6)
		@users = User.search(params[:search])
		@users_home = @users.first(6)
		@users_top5 = @users.includes(:playtimes).order("playtimes.today_playtime desc").first(5)
	end

	def search
    @users = User.search(params[:search])
    @articles = Article.search(params[:search])
  end
end
