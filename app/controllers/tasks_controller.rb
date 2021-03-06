class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  def index
    @project = Project.find(params[:project_id])
  end

  def show
      @project = Project.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
      @comments = Comment.all
      @comment = Comment.new
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new(task_params)
    @task.project_id = @project.id

    if @task.save
      redirect_to project_tasks_path(@project), notice: "Task was successfully created!"
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]
  end

  def update
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]

    if @task.update(task_params)
      redirect_to project_path(@task.project_id), notice: "Task was successfully updated!"
    else
      render :edit
  end
end

  def destroy
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]
    @task.destroy
      redirect_to project_tasks_path(@project), notice: "One less thing to do!"
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :duedate, :completed, :project_id)
    end
  end
