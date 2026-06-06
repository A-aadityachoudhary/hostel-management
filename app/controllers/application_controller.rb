class ApplicationController < ActionController::Base
  before_action :authorize_admin!, only: [:create]
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Not authorized!"
    end
  end
end