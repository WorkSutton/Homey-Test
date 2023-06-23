class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been created."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_update_params)
      flash[:notice] = "All updated"
      redirect_to @project
    # else
    # TODO No edit functionality currently required. On ticket (JIRA-nnn)
    #      - see me with 'rails notes' (previously 'rake:notes')
    #   flash.now[:alert] = "Unable to update."
    #   render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :tracking_status)
  end

  def project_update_params
    params.require(:project).permit(:tracking_status)
  end
end
