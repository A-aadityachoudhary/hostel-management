class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to admin_index_path, notice: "Room created successfully."
    else
      render :new, alert: "Failed to create room."
    end
  end

  def destroy
    @room = Room.find(params[:id])
    
    if @room.destroy
      redirect_to rooms_path, notice: "Room deleted successfully."
    else
      # This catches the restriction and shows a nice message instead of a 500 error
      redirect_to rooms_path, alert: "Cannot delete room: It has active allocations. Please remove them first."
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :block_id, :capacity)
  end
end