class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def admin_only
  	unless current_user.admin?
  		flash[:alert] = "Sorry. Access denied."
			return redirect_back(fallback_location: root_path)
  	end
	end
end
