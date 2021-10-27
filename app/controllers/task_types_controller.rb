class TaskTypesController < ApplicationController
  def new
    @task_type = TaskType.new
  end

  def create
    @task_type = TaskType.create(task_type_params)
    if @task_type.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  private

  def task_type_params
    params.require(:task_type).permit(:name)
  end
end
