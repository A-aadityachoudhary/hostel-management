class CommentsController < ApplicationController
  # Ensure the user is logged in before they can post a message
  before_action :require_login

  def create
    # Find the specific complaint being discussed
    @complaint = Complaint.find(params[:complaint_id])
    
    # Build the comment associated with this complaint and the current user
    @comment = @complaint.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to complaint_path(@complaint), notice: "Message sent."
    else
      # If the message is empty or fails validation
      redirect_to complaint_path(@complaint), alert: "Message could not be sent."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  # Ensure you have this method available (usually in ApplicationController)
  def require_login
    redirect_to login_path unless session[:user_id]
  end
end