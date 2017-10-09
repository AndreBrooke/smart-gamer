class FollowersController < ApplicationController
  def create
    @user = User.find(params[:follower][:user_id])
    followers = Follower.where(status: true)
    @follower = followers.find_or_initialize_by(follower_params)
    if @follower.id
      @follower.toggle!(:status)
      flash[:notice] = "You unfollow #{@user.nickname}"
      redirect_to user_path(@follower)
    else
      if @follower.save
        flash[:notice] = "You follow #{@user.nickname}"
        redirect_to user_path(@follower)
      else
        flash[:warning] = "#{@follower.errors.messages[0]}"
      end
    end
  end

  private
  def follower_params
    params.require(:follower).permit(:user_id, :follower_id)
  end
end
