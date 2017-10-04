class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  
  def create
      @user = User.from_omniauth(request.env['omniauth.auth'])
      @user.email = params[:user][:email] if params[:user]
    if !@user.save
      flash[:error] = "Login Fail"
    elsif @user.email == "example@na.com"
    	flash[:notice] = "Add your email please"
    	redirect_to edit_user_path(@user.id)
    else
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.nickname}!"
    end
  end

  def destroy
	  if current_user
	    session.delete(:user_id)
	    flash[:success] = "Goodbye!"
	  end
	  	redirect_to root_path
	end


end
