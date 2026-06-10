class TasksController < ApplicationController
  # 1. Ensure user is authenticated via Devise
  before_action :authenticate_user!
  
  # 2. Automatically load and authorize the @task resource
  # CanCanCan will now use Ability.rb to determine what the user can do
  load_and_authorize_resource

  def index
    # @tasks is automatically scoped by CanCanCan based on current_user's permissions
    @staff_members = User.where(role: :staff)
    @selected_staff = User.find_by(id: params[:staff_id])
    
    # Filter the authorized @tasks by the selected staff member
    if @selected_staff
      @tasks = @tasks.where(staff_id: @selected_staff.id)
    end
    
    @task = Task.new(staff: @selected_staff)
  end

  def create
  @task = Task.new(task_params)
  @task.admin_id = current_user.id
  
  if @task.save
    redirect_to tasks_path(staff_id: @task.staff_id), notice: "Task assigned successfully."
  else
    # This will show you exactly which field is causing the validation error
    error_message = @task.errors.full_messages.join(", ")
    redirect_to tasks_path(staff_id: @task.staff_id), alert: "Failed to assign task: #{error_message}"
  end
end

  def update
    # @task is already loaded and authorized by CanCanCan
    if @task.update(task_params)
      redirect_to tasks_path(staff_id: @task.staff_id), notice: "Task updated."
    else
      redirect_to tasks_path(staff_id: @task.staff_id), alert: "Update failed."
    end
  end

  def destroy
    # @task is already loaded and authorized by CanCanCan
    staff_id = @task.staff_id
    @task.destroy
    redirect_to tasks_path(staff_id: staff_id), notice: "Task deleted successfully."
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :staff_id)
  end
end