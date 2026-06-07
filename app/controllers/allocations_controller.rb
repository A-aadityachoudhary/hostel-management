class AllocationsController < ApplicationController
  before_action :authorize_admin!

  def create
    if Allocation.where(student_id: allocation_params[:student_id], status: :active).exists?
      redirect_to admin_index_path, alert: "This student is already assigned to an active room."
      return
    end
    @allocation = Allocation.new(allocation_params)
    @allocation.status = :active
    if @allocation.save
      redirect_to admin_index_path, notice: "Student successfully allocated to room!"
    else
      puts "ALLOCATION ERRORS: #{@allocation.errors.full_messages}"
      redirect_to admin_index_path, alert: "Failed to assign room."
    end
  end

  def update
    @allocation = Allocation.find(params[:id])
    @allocation.update(status: :inactive, check_out_date: Date.today)
    redirect_to admin_index_path, notice: "Student checked out successfully."
  end

  private
  def allocation_params
    params.require(:allocation).permit(:student_id, :room_id, :check_in_date)
  end
end