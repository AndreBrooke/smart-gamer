class CommendationController < ApplicationController
	def update 
		add = Commendation.find(params[:id])
		add.increment!(:count)
		current_user.likes.create(commendation_id: params[:id])
		@like = Like.find_by(commendation_id: params[:id])
		if @like.vote_type == false
			@like.update_attribute(:vote_type, true)
		end
		respond_to do |format|
			format.html { redirect_to @url }
			format.js
		end
	end
end