class ProfileController < ApplicationController
  # 1. Standard Devise authentication
  before_action :authenticate_user!
  
  # 2. Authorization: Ensure the user can only view their own profile
  # We use authorize! to check permissions
  before_action :authorize_profile_access

  def show
    # @allocation is scoped specifically to the current_user
    @allocation = Allocation.find_by(student_id: current_user.id, status: :active)
  end

  private

  def authorize_profile_access
    # Check if the user is authorized to read their own profile
    authorize! :read, :profile
  end
end