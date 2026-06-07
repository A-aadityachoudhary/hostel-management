class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def logged_in?
    !!current_user
  end

  # Added this to prevent the NoMethodError in your StaffDashboardController
  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page."
      redirect_to login_path
    end
  end

  def authorize_admin!
    # Ensure user is logged in AND is an admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to access this."
      redirect_to login_path
    end
  end
end