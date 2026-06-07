class ProfileController < ApplicationController
  # Change 'authenticate_user!' to the method you use to protect other pages
  # For example, if you use a method called 'require_login' or 'authorize_user!'
  before_action :require_login 

  def show
    @allocation = Allocation.find_by(student_id: current_user.id, status: :active)
  end

  private

  # If you don't have this method yet, add it:
  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page."
      redirect_to login_path
    end
  end
end