class UsersController < ApplicationController
  include UsersHelper
  def index
    @users = User.all
  end

  def create_user_notifications
    if signed_in? && current_user.personastate == 1
      render json: current_user.create_user_notifications
    end
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
          # chart1 = @user.playtimes.group_by_day(:date, last: 30).sum(:today_playtime)
          chart1 = @user.playtimes.group_by_day(:date, range: Date.today-30..Date.today).sum(:today_playtime)
          chart1.transform_values! {|value| value/60 }
          chart2 = chart1.transform_values {|value| @user.desired_playtime}
          @chart = [{name: "Playtime", data: chart1}, {name: "Target", data: chart2}]
          response = get_owned_games(@user) 
          game = JSON.parse(response.body)
          @games = game["response"]["games"]

          response1 = get_recent_games(@user)
          recent_game = JSON.parse(response1.body)
          @recent_games = recent_game["response"]["games"]

          response2 = get_toxicidity_score(@user)
          @words = JSON.parse(response2.body)
          
          @badges = Badge.all
          @commendations = @user.commendations
          @like = Like.find_by(params[:commendation_id])
        end
    else
      flash[:notice] = "User not found"
      redirect_to root_path
    end
  end

  def update_chart
    date = params[:chart][:date].partition(' to ')
    start_date = Date.parse(date[0])
    end_date = Date.parse(date[2])
    @user = User.find_by_id(params[:id])
    if params[:chart_option] == "day"
      chart1 = @user.playtimes.group_by_day(:date, range: start_date..end_date).sum(:today_playtime)
      chart2 = chart1.transform_values {|value| @user.desired_playtime}
    elsif params[:chart_option] == "week"
      chart1 = @user.playtimes.group_by_week(:date, range: start_date..end_date).sum(:today_playtime)
      chart2 = chart1.transform_values {|value| @user.desired_playtime*7}
    else
      chart1 = @user.playtimes.group_by_month(:date, range: start_date..end_date).sum(:today_playtime)
      chart2 = chart1.transform_values {|value| @user.desired_playtime*30}
    end
    chart1.transform_values! {|value| value/60 }
    @chart = [{name: "Playtime", data: chart1}, {name: "Target", data: chart2}]
    respond_to do |format|
      format.js
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
		params.require(:user).permit(:name, :email, :nickname, :privacy, :desired_playtime, :about)
	end
end
