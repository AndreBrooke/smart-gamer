class FollowersController < ApplicationController
  def create
    @user = User.find(params[:follower][:follower_id])
    followers = Follower.all
    @follower = followers.find_or_initialize_by(follower_params)
    if @follower.id
      if @follower.status
        @follower.update_attribute(:status, false)
        flash[:notice] = "You unfollow #{@user.nickname}"
      else
        @follower.update_attribute(:status, true)
        flash[:notice] = "You follow #{@user.nickname}"
      end
      redirect_to user_path(@follower.follower_id)
    else
      if @follower.save
        flash[:notice] = "You follow #{@user.nickname}"
        redirect_to user_path(@follower.follower_id)
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
