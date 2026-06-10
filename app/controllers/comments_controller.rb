class CommentsController < ApplicationController
  # Ensure user is logged in
  before_action :authenticate_user!
  
  # Automatically load the parent @complaint and build/authorize the @comment
  load_and_authorize_resource :complaint
  load_and_authorize_resource :comment, through: :complaint

  def create
    # @comment is already built and associated with @complaint and current_user
    @comment.user = current_user
    
    if @comment.save
      redirect_to complaint_path(@complaint), notice: "Message sent."
    else
      redirect_to complaint_path(@complaint), alert: "Message could not be sent."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end