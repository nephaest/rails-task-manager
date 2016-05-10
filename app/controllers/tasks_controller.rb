class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :check]

  def index
    @tasks = params[:all] ? Task.order(created_at: :desc) : Task.where(done: false).order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    redirect_to  @task.save ? tasks_path : new_task_path
  end

  def edit
  end

  def update
    redirect_to @task.update(task_params) ? tasks_path : edit_task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def check
    @task.done = true
    @task.save
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :done)
  end
end
