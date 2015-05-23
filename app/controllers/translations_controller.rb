class TranslationsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])

    gon.projectId = @project.id
    gon.projectName = @project.name
  end
end
