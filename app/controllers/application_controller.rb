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

  def authorize_admin!
    # Only redirect if not already logged in as admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to access this."
      redirect_to login_path # Redirect to login instead of root
    end
  end
end