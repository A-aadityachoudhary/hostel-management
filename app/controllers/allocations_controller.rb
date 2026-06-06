class AllocationsController < ApplicationController
  def create
    # Example: Admin selects a student and a room
    @allocation = Allocation.new(
      student_id: params[:student_id],
      room_id: params[:room_id],
      check_in_date: Date.today,
      status: :active
    )

    if @allocation.save
      redirect_to root_path, notice: "Room allocated successfully!"
    else
      redirect_to root_path, alert: "Allocation failed."
    end
  end
end