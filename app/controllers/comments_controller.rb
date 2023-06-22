class CommentsController < ApplicationController
  before_action :set_project

  def new
    @comment = @project.comments.build
  end

  def create
    @comment = @project.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@project, @comment]
    end
  end

  def show
    @comment = @project.comments.find(params[:id])
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:detail)
  end
end
