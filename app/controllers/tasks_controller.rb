class TasksController < ApplicationController
  before_action :authorize_admin!, only: [:index, :create, :update, :destroy]

  def index
    @staff_members = User.where(role: :staff)
    @selected_staff = User.find_by(id: params[:staff_id]) # Use find_by to avoid errors if ID is invalid
    @tasks = @selected_staff ? @selected_staff.tasks : []
    @task = Task.new(staff: @selected_staff)
  end

  def create
    @task = Task.new(task_params)
    @task.admin_id = current_user.id
    
    if @task.save
      # Redirect back with the staff_id so the UI stays focused on the same person
      redirect_to tasks_path(staff_id: @task.staff_id), notice: "Task assigned successfully."
    else
      redirect_to tasks_path(staff_id: @task.staff_id), alert: "Failed to assign task: #{@task.errors.full_messages.join(', ')}"
    end
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      redirect_to tasks_path(staff_id: @task.staff_id), notice: "Task updated."
    else
      redirect_to tasks_path(staff_id: @task.staff_id), alert: "Update failed."
    end
  end

  def destroy
    @task = Task.find(params[:id])
    staff_id = @task.staff_id
    @task.destroy
    redirect_to tasks_path(staff_id: staff_id), notice: "Task deleted successfully."
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :staff_id)
  end
end