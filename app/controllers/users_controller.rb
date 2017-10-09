class UsersController < ApplicationController
  def index
    @users = User.all
  end

	def edit
    if signed_in? && (current_user.id == params[:id].to_i)
    	@user = User.find(params[:id])
    else
      flash[:notice] = "You are not authorise."
      redirect_to root_path
    end
  end

	def update
    if signed_in? && (current_user.id == params[:id].to_i)
    	@user = User.find(params[:id])
    	if @user.update(user_params)
    	  redirect_to user_path(@user)
      else
        flash[:notice] = "Incorrect Email"
        render 'edit'
      end
    else
      flash[:notice] = "You are not authorise"
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user
      if signed_in?
        @private = @user.privacy_check(current_user)
        @private = false if current_user.id == params[:id].to_i
      else
        @private = @user.privacy_check
      end
        if @private == false
          chart1 = @user.playtimes.group_by_day(:date).sum(:today_playtime)
          chart1.transform_values! {|value| value/60 }
          chart2 = chart1.transform_values {|value| @user.desired_playtime}
          @chart = [{name: "Playtime", data: chart1}, {name: "Target", data: chart2}]
          @badges = Badge.all
          @commendations = @user.commendations
          @like = Like.find_by(params[:commendation_id])
        end
    else
      flash[:notice] = "User not found"
      redirect_to root_path
    end
  end

  def admin_page
    if current_user.admin?
      redirect_to articles_path
    else
      redirect_to root_path
    end
  end

  private

	def user_params
		params.require(:user).permit(:name, :email, :nickname, :privacy, :desired_playtime)
	end
end
