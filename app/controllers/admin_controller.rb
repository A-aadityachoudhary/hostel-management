class AdminController < ApplicationController
  # 1. Ensure user is logged in via Devise
  before_action :authenticate_user!
  
  # 2. Use CanCanCan to authorize access to the dashboard
  before_action :authorize_admin_dashboard

  def index
    @students = User.where(role: :student)
    @rooms = Room.all
  end

  private

  def authorize_admin_dashboard
    # Checks the :read permission for the :admin_dashboard symbol
    authorize! :read, :admin_dashboard
  end
end