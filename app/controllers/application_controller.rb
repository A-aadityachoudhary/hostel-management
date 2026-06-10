class ApplicationController < ActionController::Base
  # 1. Enforce authorization globally for all controllers
  check_authorization unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 2. Handle unauthorized access (CanCanCan access denied error)
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  protected

  def configure_permitted_parameters
    # Permit :name and :role for registration
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    
  end
end