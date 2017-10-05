class FollowersController < ApplicationController
  def create
    @user = User.find(params[:follower][:user_id])
    followers = Follower.where(status: true)
    @follower = followers.find_or_initialize_by(follower_params)
    if @follower.id
      @follower.update(status: false)
      redirect_to user_path(@user)
    else
      if @follower.save
        flash[:notice] = "You follow #{@user}"
        redirect_to user_path(@user)
      else
        flash[:warning] = "#{@follower.errors.messages[0]}"
      end
    end
  end

  def destroy

  end

  private
  def follower_params
    params.require(:follower).permit(:user_id, :follower_id)
  end
end
