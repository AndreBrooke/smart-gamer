class NotificationMailer < ApplicationMailer

  def exceed(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You have exceed playtime")
  end

  def online_after_exceed(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You have exceed playtime, go offline")
  end

end
