class ProjectsController < ApplicationController
  def index
    projects = Project.all
    render json: projects
  end

  def create
    project = Project.new(project_params)
    if project.save
      render json: project, status: 201, location: project
    else
      render json: project.errors, status: 422
    end
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
