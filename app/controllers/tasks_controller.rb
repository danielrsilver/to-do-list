class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  # GET /tasks
  def index
    @task = Task.new
    if params[:completed] == "true"
      @tasks = Task.completed
    else
      @tasks = Task.incomplete
    end
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path,
        notice: 'Task was successfully created.'
    else
      redirect_to tasks_path,
        notice: "Could not save task: #{@task.errors.full_messages.join(', ')}"
    end
  end

  # PATCH /tasks
  def update
    @task.update(task_params)
    redirect_back(fallback_location: root_path, notice: "Task was successfully updated.") 
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url,
      notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :completed)
    end
end
