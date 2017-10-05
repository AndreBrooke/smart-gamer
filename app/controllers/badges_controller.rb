class BadgesController < ApplicationController
	def create
		Badge.new(user_id: 1, achievement_id: 1)
	end

	def destroy

	end
end
