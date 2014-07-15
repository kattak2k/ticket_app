class Api::ProjectsController < Api::BaseController
  def index
    projects = Project.all
    respond_with projects
  end

  def create
    project = Project.create(project_params)
    respond_with :api, project
  end

  def update
    project = Project.find(params[:id])
    project.update(project_params)
    respond_with :api, project
  end

  def destroy
    project = Project.find(params[:id])
    respond_with project.destroy
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
