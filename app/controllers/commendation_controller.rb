class CommendationController < ApplicationController

	def update
		add = Commendation.find(params[:id])
		add.increment!(:count)
	end
end
