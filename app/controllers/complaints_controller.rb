class ComplaintsController < ApplicationController
  before_action :authenticate_user!
  
  # load_and_authorize_resource will handle @complaint and @complaints
  load_and_authorize_resource

  def index
    # CanCanCan has already scoped @complaints based on Ability.rb
    @complaints = @complaints.order(created_at: :desc)
    
    # We build a new one for the 'new' form in case you want to show 
    # the form on the same page as the history
    @complaint = Complaint.new 
  end

  def create
    # Use the strong params method here
    @complaint.user = current_user
    if @complaint.save
      redirect_to complaints_path, notice: "Complaint submitted successfully."
    else
      # If create fails, re-load the index data to show the list again
      @complaints = Complaint.accessible_by(current_ability).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def new
  # Build the new complaint for the form
  @complaint = Complaint.new
  # Fetch history so the view has something to display
  @complaints = Complaint.accessible_by(current_ability).order(created_at: :desc)
end

  def show
    @comments = @complaint.comments.order(created_at: :asc)
    @comment = Comment.new
  end

  def update
    if @complaint.update(reply_params)
      redirect_to complaint_path(@complaint), notice: "Reply sent successfully."
    else
      redirect_to complaint_path(@complaint), alert: "Failed to send reply."
    end
  end
  
  def destroy
    @complaint.destroy
    redirect_to complaints_path, notice: "Complaint deleted."
  end

  private

  def complaint_params
    params.require(:complaint).permit(:message)
  end

  def reply_params
    params.require(:complaint).permit(:reply) # Ensure this matches your form field
  end
end