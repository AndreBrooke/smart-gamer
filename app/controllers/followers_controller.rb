class FollowersController < ApplicationController
  def create
    @user = User.find(params[:follower][:user_id])
    @follower = Follower.new(follower_params)
    if @follower.save
      flash[:notice] = "You follow #{@user}"
      redirect_to user_path(@user)
    end
  end

  private
  def follower_params
    params.require(:follower).permit(:user_id, :follower_id)
  end
end
