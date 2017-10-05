class UserAchievementsController < ApplicationController
	def new
		@achievement = UserAchievement.new
	end

	def create
		@achievement = UserAchievement.new(achievement_params)
		if @achievement.save
			@achievement = UserAchievement.all
			redirect_to user_path(current_user.id)
			flash[:success] = "Created the achivements!"
		else
			render "new"
			flash[:notice] = "Didnt work"
		end
	end

	private

	def achievement_params
		params.require(:user_achievement).permit(:image, :name, :description)
	end
end

#set condition for achievement for users
#what are the condition? e.g achievement_1 unlock if game play hour < 2 hours in 1 day 
												#e.g achievement_2 unlock if game play hour <= 15 hours in 1 week
												#e.g achievement_3 unlock if game play hour 10 min 
#how to set condition for achievements 
#if achieve condition award achievement maybe show different color font for now
#same achievement cannot be achieve again