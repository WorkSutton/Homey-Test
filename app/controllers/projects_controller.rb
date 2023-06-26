class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :update]

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
  end

  def update
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

  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking for could not be found!"
    redirect_to projects_path
  end

  def project_params
    params.require(:project).permit(:title, :description, :tracking_status)
  end

  def project_update_params
    params.require(:project).permit(:tracking_status)
  end
end
