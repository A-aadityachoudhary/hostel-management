class AllocationsController < ApplicationController
  # Require user to be logged in
  before_action :authenticate_user!
  
  # Automatically load and authorize the @allocation resource
  load_and_authorize_resource

  def create
    # Check for existing active allocation before saving
    if Allocation.where(student_id: allocation_params[:student_id], status: :active).exists?
      redirect_to admin_index_path, alert: "This student is already assigned to an active room."
      return
    end

    @allocation.status = :active
    
    if @allocation.save
      redirect_to admin_index_path, notice: "Student successfully allocated to room!"
    else
      redirect_to admin_index_path, alert: "Failed to assign room: #{@allocation.errors.full_messages.join(', ')}"
    end
  end

  def update
    # @allocation is already loaded by load_and_authorize_resource
    if @allocation.update(status: :inactive, check_out_date: Date.today)
      redirect_to admin_index_path, notice: "Student checked out successfully."
    else
      redirect_to admin_index_path, alert: "Failed to check out student."
    end
  end

  private

  def allocation_params
    params.require(:allocation).permit(:student_id, :room_id, :check_in_date)
  end
end