class StaffDashboardController < ApplicationController
  # This now calls the method we defined in ApplicationController
  before_action :require_login
  before_action :authorize_staff_or_admin!

  def index
    # Fetch only tasks assigned to this specific staff member
    @my_tasks = Task.where(staff_id: current_user.id).order(created_at: :desc)
  end

  private

  def authorize_staff_or_admin!
    # Ensure the user has the 'staff' or 'admin' role
    unless current_user&.staff? || current_user&.admin?
      redirect_to root_path, alert: "Access denied. Only staff can view this dashboard."
    end
  end
end