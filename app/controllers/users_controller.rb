class UsersController < ApplicationController
	def edit
  	@user = User.find(params[:id])
  end

	def update
  	@user = User.find(params[:id])
  	if @user.update(email_params)
  	  redirect_to user_path(@user)
    else
      flash[:notice] = "Incorect Email"
      render 'users/edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def admin_page
    if current_user.admin?
      redirect_to articles_path
    end
  end

  private

	def email_params
		params.require(:user).permit(:email)
	end
end
