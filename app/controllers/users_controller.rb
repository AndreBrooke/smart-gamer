class UsersController < ApplicationController

	def edit
  	@user = User.find(params[:id])
  end

	def update
  	@user = User.find(params[:id])
  	@user.update(email_params)
  	redirect_to 
  end

  private

	def email_params
		params.require(:user).permit(:email)
	end
end
