class ComplaintsController < ApplicationController
  before_action :require_login
  # Only admins can delete; admins and owners of the complaint can view
  before_action :ensure_admin!, only: [:destroy]

  def index
    if current_user.admin?
      @complaints = Complaint.all.order(created_at: :desc)
    else
      # Students/Staff only see their own complaints
      @complaints = current_user.complaints.order(created_at: :desc)
    end
  end

  def new
    @complaint = Complaint.new
    @complaints = current_user.complaints.order(created_at: :desc)
  end

  def create
    @complaint = current_user.complaints.build(complaint_params)
    if @complaint.save
      redirect_to new_complaint_path, notice: "Complaint submitted successfully."
    else
      # We must set @complaints here so the view has data to iterate over
      @complaints = current_user.complaints.order(created_at: :desc)
      flash.now[:alert] = "Failed to submit complaint."
      render :new
    end
  end

  def show
    @complaint = Complaint.find(params[:id])
    unless current_user.admin? || @complaint.user_id == current_user.id
      redirect_to complaints_path, alert: "Access Denied."
      return
    end
    @comments = @complaint.comments.order(created_at: :asc)
    @comment = Comment.new
  end

  # This handles the Admin's reply
  def update
    @complaint = Complaint.find(params[:id])
    
    # Only admins should be able to update/reply to a complaint
    if current_user.admin? && @complaint.update(reply_params)
      redirect_to complaints_path, notice: "Reply sent successfully."
    else
      redirect_to complaints_path, alert: "Failed to send reply or unauthorized."
    end
  end
  
  def destroy
    @complaint = Complaint.find(params[:id])
    @complaint.destroy
    redirect_to complaints_path, notice: "Complaint deleted."
  end

  private

  def complaint_params
    params.require(:complaint).permit(:message)
  end

  # Allow the reply field to be updated
  def reply_params
    params.require(:complaint).permit(:reply)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to do that."
    end
  end

  def ensure_admin!
    unless current_user&.admin?
      redirect_to complaints_path, alert: "Access Denied."
    end
  end
end