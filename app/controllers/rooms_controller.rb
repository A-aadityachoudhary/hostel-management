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
    @room.destroy
    redirect_to admin_index_path, notice: "Room deleted successfully."
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :block_id, :capacity)
  end
end