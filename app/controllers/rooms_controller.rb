class RoomsController < ApplicationController
  # Require user to be logged in
  before_action :authenticate_user!
  
  # Automatically load and authorize the @room resource
  load_and_authorize_resource

  def new
    # @room is already initialized by load_and_authorize_resource
  end

  def create
    # @room is already initialized with room_params
    if @room.save
      redirect_to admin_index_path, notice: "Room created successfully."
    else
      render :new, alert: "Failed to create room."
    end
  end

  def destroy
    # @room is already loaded and authorized
    if @room.destroy
      redirect_to rooms_path, notice: "Room deleted successfully."
    else
      redirect_to rooms_path, alert: "Cannot delete room: It has active allocations. Please remove them first."
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :block_id, :capacity)
  end
end