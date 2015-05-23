class SchemataController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @projects = [@project] + Project.all.where.not(id: @project.id)
    @version = if params[:version]
                 Version.find_by(project_id: @project.id, name: params[:version])
               else
                 @project.versions.order(id: :desc).first()
               end
    @versions = [@version] + @project.versions.where.not(id: @version.id).order(id: :desc)

    gon.project_id = @project.id
    gon.version_id = @version.id
  end
end
