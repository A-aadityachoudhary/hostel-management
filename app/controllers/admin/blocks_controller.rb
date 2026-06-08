class Admin::BlocksController < ApplicationController
  def create
    @block = Block.new(block_params)
    if @block.save
      redirect_to admin_blocks_path, notice: "Block created successfully."
    else
      render :new, alert: "Failed to create block."
    end
  end

  private

  def block_params
    params.require(:block).permit(:name)
  end
end