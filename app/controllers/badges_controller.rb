class BadgesController < ApplicationController
	def create
		byebug
		if UserAchievements
			Badge.new(user_id: 1, achievement_id: 1)
		end
	end

	def destroy

	end
end
