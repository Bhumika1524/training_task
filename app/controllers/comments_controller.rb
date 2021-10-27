class CommentsController < ApplicationController
  def index
    @tasks = Task.all
    @comments = Comment.all
  end

  def edit
    @task = Task.find_by(id: params[:task_id])
    @comments = @task.comments
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:task_id])
    @comment = Comment.find_by(id: params[:id])
    if @comment.user_id == current_user.id
      if @comment.update(comment_params)
        redirect_to task_path(@task.id)
      else
        render :edit
      end
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def destroy
    @task = Task.find_by(params[:task_id])
    @comment = Comment.find_by(id: params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
    end
    redirect_to task_path(@task.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :task_id, :user_id, :_destroy)
  end

end
