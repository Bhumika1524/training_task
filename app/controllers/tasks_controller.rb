class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task_types = TaskType.all
    @users = User.where.not(:id=>current_user.id)
    @task_statuses = TaskStatus.all
  end

  def create
    @users = User.where.not(:id=>current_user.id)
    @task_types = TaskType.all
    @task_statuses = TaskStatus.all
    @task = current_user.from.create(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    @task_types = TaskType.all
    @users = User.where.not(:id=>current_user.id)
    @task_statuses = TaskStatus.all
  end

  def update
    @task_types = TaskType.all
    @users = User.where.not(:id=>current_user.id)
    @task_statuses = TaskStatus.all
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
    @comments = @task.comments
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to task_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :to_id, :from_id, :type_id, :status_id,
                                 comments_attributes: %i[id name task_id user_id _destroy])
  end
end
