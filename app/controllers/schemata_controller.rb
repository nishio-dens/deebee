class SchemataController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @projects = [@project] + Project.all.where.not(id: @project.id)
    @versions = @project.versions.order(id: :desc)
  end
end
