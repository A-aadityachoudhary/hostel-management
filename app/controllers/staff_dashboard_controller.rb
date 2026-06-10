class StaffDashboardController < ApplicationController
  # 1. Devise handles login
  before_action :authenticate_user!
  
  # 2. CanCanCan handles authorization
  # We use :read for the dashboard, mapping to the ability definition
  before_action :authorize_dashboard

  def index
    # Filter tasks using the current_user object provided by Devise
    @tasks = Task.where(staff: current_user).order(created_at: :desc)
  end

  private

  def authorize_dashboard
    authorize! :read, :staff_dashboard
  end
end